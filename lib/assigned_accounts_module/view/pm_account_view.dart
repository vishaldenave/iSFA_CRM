import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/assigned_accounts_module/assigned_accounts_repository.dart';
import 'package:isfa_crm/assigned_accounts_module/bloc/assigned_accounts_bloc.dart';
import 'package:isfa_crm/assigned_accounts_module/models/assigned_accounts_model.dart';
import 'package:isfa_crm/utility/app_storage.dart';

class PMAccountView extends StatefulWidget {
  const PMAccountView({super.key});
  @override
  State<PMAccountView> createState() => _PMAccountViewState();
}

class _PMAccountViewState extends State<PMAccountView> {
  bool isCaimpaignNameSelecting = false;
  bool showContants = false;
  AssignedAccountsModel? assignedAccountsModel;
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    String role = AppStorage().userDetail?.role ?? "";

    return Scaffold(
      body: RepositoryProvider(
        create: (context) => AssignedAccountsRepository(),
        child: BlocProvider(
          create: (context) => AssignedAccountsBloc(context.read())
            ..add(AssignedAccountShowCurrentEvent()),
          child: BlocConsumer<AssignedAccountsBloc, AssignedAccountsState>(
            listener: (context, state) {},
            builder: (context, state) {
              var bloc = context.read<AssignedAccountsBloc>();
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  elevation: 5,
                                  padding: const EdgeInsets.all(15)),
                              child: Text(role,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15.sp)))
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              elevation: 5,
                              child: ListTile(
                                onTap: () {
                                  isCaimpaignNameSelecting =
                                      !isCaimpaignNameSelecting;
                                  bloc.add(AssignedAccountShowAllEvent());
                                  showContants = false;
                                },
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Caimpaign Name"),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                ),
                                subtitle: bloc.current != null
                                    ? Text(bloc.current?.campaignName ?? "")
                                    : const Text("Loading...."),
                                trailing: Icon(isCaimpaignNameSelecting
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          if (isCaimpaignNameSelecting &&
                              (state is AssignedAccountsAllState ||
                                  state is SearchState))
                            Card(
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
                                        child: ListView.builder(
                                          itemCount: bloc.filteredList.length,
                                          itemBuilder: (context, index) =>
                                              SizedBox(
                                            height: 50.h,
                                            child: ListTile(
                                              onTap: () {
                                                isCaimpaignNameSelecting =
                                                    false;

                                                showSwitchAlert(
                                                    context,
                                                    bloc.filteredList[index]
                                                        .campaignName,
                                                    bloc.current
                                                            ?.campaignName ??
                                                        "",
                                                    () => {
                                                          bloc.add(
                                                              AssignedAccountUpdateCurrentEvent(bloc
                                                                  .filteredList[
                                                                      index]
                                                                  .campaignId)),
                                                        },
                                                    () => {
                                                          bloc.add(
                                                              AssignedAccountShowCurrentEvent())
                                                        });
                                              },
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              title: state is SearchState
                                                  ? Text(
                                                      bloc.filteredList[index]
                                                          .campaignName,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 13.sp),
                                                    )
                                                  : Text(
                                                      bloc.filteredList[index]
                                                          .campaignName,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 13.sp)),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      AccountCardView(
                        isSelected: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Campaign Type:",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                bloc.current?.campaignType ?? "",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      AccountCardView(
                        isSelected: false,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Campaign ID:",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                bloc.current?.campaignId.toString() ?? "",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      AccountCardView(
                        isSelected: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Start Date:",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  bloc.current?.startDate ?? "",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "End Date:",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  bloc.current?.endDate ?? "",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.amber, elevation: 2),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.35.sw, vertical: 5.h),
                          child: const Text(
                            "ACCOUNTS",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showSwitchAlert(BuildContext context, String updateCurrent,
    String previousCurrent, Function callbackYes, Function callbackNo) {
  showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 3,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
          child: Padding(
            padding: EdgeInsets.all(15.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Do you want to switch the campaign?",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Text(
                  "$previousCurrent -> $updateCurrent",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AlertButton(
                      isSelected: false,
                      text: 'No',
                      onPressed: () {
                        callbackNo();
                        Navigator.pop(context);
                      },
                    ),
                    AlertButton(
                      isSelected: true,
                      text: 'Yes',
                      onPressed: () {
                        callbackYes();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
}

class AlertButton extends StatelessWidget {
  final bool isSelected;
  final String text;
  final void Function()? onPressed;
  const AlertButton({
    super.key,
    required this.isSelected,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.w),
          ),
          backgroundColor: isSelected ? Colors.amber : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 25.w),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.grey),
          ),
        ));
  }
}

class AccountCardView extends StatelessWidget {
  final Widget child;
  final bool isSelected;
  const AccountCardView({
    super.key,
    required this.child,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
        child: child,
      ),
    );
  }
}

class NameInitial extends StatelessWidget {
  const NameInitial({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      padding: const EdgeInsets.all(8.0),
      child: Text(
        name.nameCharaters,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

extension Name on String {
  String get nameCharaters {
    return split(' ').map((e) => e.isEmpty ? '' : e[0]).join();
  }
}
