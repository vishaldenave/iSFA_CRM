import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isfa_crm/accounts_module/accounts_repository.dart';
import 'package:isfa_crm/accounts_module/bloc/accounts_bloc.dart';
import 'package:isfa_crm/routes.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accounts"),
      ),
      body: RepositoryProvider(
        create: (context) => AccountsRepository(),
        child: BlocProvider(
          create: (context) =>
              AccountsBloc(context.read())..add(ShowAccountsNameEvent()),
          child: BlocConsumer<AccountsBloc, AccountsState>(
            listener: (context, state) {
              if (state is AccountErrorMesssage) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is MoveToSaveFeedback) {
                context.push(AppPaths.callDisposition, extra: state.callData);
              }
            },
            builder: (context, state) {
              var bloc = context.read<AccountsBloc>();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.add(ChangeAccountSelectEvent(
                            !bloc.isAccountNameSelecting));
                        bloc.showContants = false;
                      },
                      child: Card(
                        margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
                        elevation: 2,
                        child: ListTile(
                          title: Text(
                            "Account Name",
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(bloc.selectedOrg == null
                              ? "Select"
                              : bloc.selectedOrg?.orgName ??
                                  "Name not available"),
                          trailing: Icon(bloc.isAccountNameSelecting
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if (bloc.showContants)
                      MaterialButton(
                        onPressed: () {
                          bloc.add(ShowAddContactEvent());
                          // bloc.showAddContactDialog = true;
                          showAddContactDialog(
                              bloc.selectedOrg?.orgId ?? "-1", context, bloc);
                          // BlocProvider.value(
                          //     value: bloc,
                          //     child: showAddContactDialog(
                          //         bloc.selectedOrg?.orgId ?? "-1",
                          //         context,
                          //         bloc));
                        },
                        color: Colors.yellow,
                        child: const Text("Add contacts"),
                      ),
                    if (bloc.isAccountNameSelecting)
                      Card(
                        margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.w),
                        elevation: 2,
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Column(
                            children: [
                              Material(
                                elevation: 2,
                                borderRadius: BorderRadius.circular(5.w),
                                color: Colors.white,
                                child: TextField(
                                  onChanged: (value) =>
                                      bloc.add(SearchEvent(value)),
                                  decoration: const InputDecoration(
                                    hintText: 'Search...',
                                    border: InputBorder.none,
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: 200.h,
                                  child: bloc.orgList.isNotEmpty
                                      ? ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: bloc.filteredList.length,
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                            onTap: () {
                                              bloc.showContants = true;
                                              bloc.add(ChangeAccountSelectEvent(
                                                  false));

                                              bloc.add(ShowSelectedAccountEvent(
                                                  bloc.filteredList[index]));
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                  bloc.filteredList[index]
                                                      .orgName,
                                                  style: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14.sp)),
                                            ),
                                          ),
                                        )
                                      : const Center(
                                          child: Text("No Data found."),
                                        )),
                            ],
                          ),
                        ),
                      ),
                    if (bloc.showContants)
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: bloc.contactList.length,
                          padding: EdgeInsets.all(10.w),
                          separatorBuilder: (context, index) => SizedBox(
                                height: 10.w,
                              ),
                          itemBuilder: (context, index) => Material(
                                elevation: 1,
                                borderRadius: BorderRadius.circular(10.w),
                                color: Colors.white,
                                child: ListTile(
                                  title: Text(
                                    bloc.contactList[index].contactName ?? "",
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          bloc.contactList[index].designation ??
                                              ""),
                                      Text(
                                          bloc.contactList[index].mobile ?? ""),
                                    ],
                                  ),
                                  isThreeLine: true,
                                  trailing: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        border: Border.all(
                                            color: Colors.grey.shade300),
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: IconButton(
                                        onPressed: () {
                                          bloc.add(MakeCallEvent(
                                              bloc.contactList[index]));
                                        },
                                        icon: const Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              )),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  void showAddContactDialog(
      String orgId, BuildContext context, AccountsBloc bloc) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocProvider(
            create: (context) => bloc,
            child: BlocConsumer<AccountsBloc, AccountsState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Dialog(
                  elevation: 3,
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.w),
                      borderSide: BorderSide.none),
                  child: Padding(
                    padding: EdgeInsets.all(13.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Add new contact",
                                style: TextStyle(fontSize: 20),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.cancel))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (state is FailedAddContactState)
                            Text(
                              state.message,
                              style: const TextStyle(color: Colors.red),
                            ),
                          if (state is SuccessAddContactState)
                            Text(
                              state.successMessage,
                              style: const TextStyle(color: Colors.green),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text("Name"),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          TextField(
                            controller: bloc.nameController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text("Designation"),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          TextField(
                            controller: bloc.designationController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text("Mobile Number"),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          TextField(
                            controller: bloc.mobileController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Row(
                            children: [
                              Text("Email ID"),
                              Text(
                                "*",
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                          TextField(
                            controller: bloc.emailController,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                            onPressed: () {
                              bloc.add(AddContactEvent(orgId));
                            },
                            color: Colors.green[400],
                            child: const Text(
                              "SAVE",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
