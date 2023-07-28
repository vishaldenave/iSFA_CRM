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
  String programManager = AppStorage().userDetail?.programManager ?? "";
  String teamLead = AppStorage().userDetail?.teamLeader ?? "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Assigned Accounts"),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Colors.blue, //: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 0.5,
                                        offset: const Offset(0, 0.5))
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text("PM",
                                    style: TextStyle(
                                      color: Colors.white, //: Colors.blue,
                                      fontWeight:
                                          FontWeight.bold, //: FontWeight.normal
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                NameInitial(name: programManager),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  programManager,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              width: 100.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                  color: Colors.blue, //: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade100,
                                        spreadRadius: 0.5,
                                        offset: const Offset(0, 0.5))
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text("Team Lead",
                                    style: TextStyle(
                                      color: Colors.white, //: Colors.blue,
                                      fontWeight:
                                          FontWeight.bold, //: FontWeight.normal
                                    )),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                NameInitial(name: teamLead),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Text(
                                  teamLead,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )),
      ),
      body: const PMAccountView(),
    );
  }
}
