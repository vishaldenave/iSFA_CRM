import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/accounts_view.dart';
import 'package:isfa_crm/assigned_accounts_view.dart';
import 'package:isfa_crm/pm_account_view.dart';

class TabbarView extends StatelessWidget {
  const TabbarView({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Ankita';
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                const NameInitial(name: name),
                SizedBox(width: 10.w),
                const Text(name),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_outlined),
              ),
              IconButton(
                onPressed: () {},
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
                    // TabbarItem(icon: Icons.home, isSelected: true),
                    // TabbarItem(icon: Icons.groups_2, isSelected: false),
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
        ));
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
