import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/assigned_accounts_module/view/pm_account_view.dart';
import 'package:isfa_crm/utility/app_storage.dart';

class AssignedAccountView extends StatefulWidget {
  const AssignedAccountView({super.key});

  @override
  State<AssignedAccountView> createState() => _AssignedAccountViewState();
}

class _AssignedAccountViewState extends State<AssignedAccountView> {
  var tabbsData = [
    TabModel("PM", true),
    TabModel("Team Lead", false),
  ];
  String programManager = AppStorage().userDetail?.programManager ?? "";
  String teamLead = AppStorage().userDetail?.teamLeader ?? "";
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        centerTitle: true,
        title: const Text("Assigned Accounts"),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(70.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      tabbsData.length,
                      (index) => InkWell(
                          onTap: () {
                            for (var tab in tabbsData) {
                              tab.selectChange(false);
                            }
                            tabbsData[index].selectChange(true);
                            tabIndex = index;
                            setState(() {});
                          },
                          child: AssignedAccTab(data: tabbsData[index])),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      NameInitial(
                          name: tabbsData[tabIndex].name == "PM"
                              ? programManager
                              : teamLead),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        tabbsData[tabIndex].name == "PM"
                            ? programManager
                            : teamLead,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
      body: const PMAccountView(),
    );
  }
}

class AssignedAccTab extends StatelessWidget {
  final TabModel data;
  const AssignedAccTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      decoration: BoxDecoration(
          color: data.isSelected ? Colors.blue : Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1.w,
                offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(data.name,
            style: TextStyle(
                color: data.isSelected ? Colors.white : Colors.blue,
                fontWeight:
                    data.isSelected ? FontWeight.bold : FontWeight.normal)),
      ),
    );
  }
}

class TabModel {
  final String name;
  bool isSelected;

  TabModel(this.name, this.isSelected);

  void selectChange(bool val) {
    isSelected = val;
  }
}
