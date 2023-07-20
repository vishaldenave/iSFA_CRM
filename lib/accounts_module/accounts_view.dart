import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/accounts_module/accounts_repository.dart';
import 'package:isfa_crm/accounts_module/bloc/accounts_bloc.dart';
import 'package:isfa_crm/call_disposition_module/call_disposition_view.dart';
import 'package:url_launcher/url_launcher.dart';

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
            listener: (context, state) {},
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
                          subtitle: Text(bloc.showSelectedName.isEmpty
                              ? "Select"
                              : bloc.showSelectedName),
                          trailing: Icon(bloc.isAccountNameSelecting
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down),
                        ),
                      ),
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

                                          //     SizedBox(
                                          //   height: 30.h,
                                          //   child: ListTile(

                                          //     contentPadding:
                                          //         const EdgeInsets.all(0),
                                          //     title: Text(
                                          //       bloc.filteredList[index]
                                          //           .orgName,
                                          //       style: TextStyle(
                                          //           color: Colors.grey,
                                          //           fontSize: 13.sp),
                                          //     ),
                                          //   ),
                                          // ),
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
                                          launchUrl(Uri.parse(
                                              "tel:${bloc.contactList[index].mobile}"));
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CallDisposition()));
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
    );
  }
}
