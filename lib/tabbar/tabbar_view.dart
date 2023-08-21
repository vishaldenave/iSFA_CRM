import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:isfa_crm/accounts_module/accounts_view.dart';
import 'package:isfa_crm/assigned_accounts_module/view/assigned_accounts_view.dart';
import 'package:isfa_crm/assigned_accounts_module/view/pm_account_view.dart';
import 'package:isfa_crm/routes.dart';
import 'package:isfa_crm/utility/app_storage.dart';
import 'package:isfa_crm/utility/network_helper.dart';

class TabbarView extends StatelessWidget {
  const TabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    BuildContext? networkAlertContext;
    String name = AppStorage().userDetail?.username ?? "";
    return BlocProvider(
      create: (context) => NetworkBloc()..add(NetworkObserve()),
      child: BlocListener<NetworkBloc, NetworkState>(
        listener: (c, state) {
          if (state is NetworkFailure) {
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (c) {
                  networkAlertContext = c;
                  return const AlertDialog(
                    content: Text("No Internet Connection"),
                  );
                });
          } else {
            if (networkAlertContext != null) {
              Navigator.pop(networkAlertContext!);
            }
          }
        },
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    NameInitial(name: name),
                    SizedBox(width: 10.w),
                    Text(name),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showLogoutAlert(
                          context,
                          () async => {
                                await AppStorage().logout(),
                                context.pushReplacement(AppPaths.initial)
                              });
                    },
                    icon: const Icon(Icons.exit_to_app),
                  )
                ],
                elevation: 0,
              ),
              body: const Column(
                children: [
                  Material(
                    color: Colors.white,
                    elevation: 2,
                    child: TabBar(
                      indicatorColor: Colors.white12,
                      tabs: [
                        Tab(icon: Icon(Icons.home)),
                        Tab(icon: Icon(Icons.groups_2)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        AssignedAccountView(),
                        AccountsView(),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void showLogoutAlert(BuildContext context, Function callback) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 3,
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
            child: Padding(
              padding: EdgeInsets.all(15.w),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text("Do you want to log out?",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AlertButton(
                      isSelected: false,
                      text: "No",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    AlertButton(
                      isSelected: true,
                      text: "Yes",
                      onPressed: () {
                        Navigator.pop(context);
                        callback();
                      },
                    )
                  ],
                )
              ]),
            ),
          );
        });
  }
}

class TabbarItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const TabbarItem({super.key, required this.icon, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Tab(
        child: SizedBox(
          width: 1.sw,
          child: Icon(
            icon,
            color: isSelected ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
