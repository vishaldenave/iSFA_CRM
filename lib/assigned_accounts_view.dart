import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/pm_account_view.dart';

class AssignedAccountView extends StatefulWidget {
  const AssignedAccountView({super.key});

  @override
  State<AssignedAccountView> createState() => _AssignedAccountViewState();
}

class _AssignedAccountViewState extends State<AssignedAccountView> {
  var tabbsData = [
    TabModel("PM", true),
    TabModel("Team Lead", false),
    TabModel("Agents", false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Assigned Accounts"),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Padding(
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
                        setState(() {});
                      },
                      child: AssignedAccTab(data: tabbsData[index])),
                ),
              ),
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
      width: 80.w,
      height: 40.h,
      decoration: BoxDecoration(
          color: data.isSelected ? Colors.blue : Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade400,
                spreadRadius: 1.w,
                offset: const Offset(0, 1))
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.w))),
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
