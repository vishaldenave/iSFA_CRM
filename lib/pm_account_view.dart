import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PMAccountView extends StatelessWidget {
  const PMAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'Priya  Iyer';
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const NameInitial(name: name),
                SizedBox(width: 10.w),
                const Text(name),
                const Spacer(),
                TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red, elevation: 2),
                    child: const Text('GCE',
                        style: TextStyle(color: Colors.white)))
              ],
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () => showSwitchAlert(context),
              child: AccountCardView(
                isSelected: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Campaign Name",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Google Chrome Enterprise",
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        const Icon(Icons.keyboard_arrow_down)
                      ],
                    )
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
                      "Campaign Type:",
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "leadRegister",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                    Text(
                      "528",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "15th April 2023",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "15th May 2023",
                        style: TextStyle(color: Colors.grey, fontSize: 12.sp),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.35.sw, vertical: 5.h),
                  child: const Text(
                    "ACCOUNTS",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  void showSwitchAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 3,
            shape:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.w)),
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
                    "Google enterprise -> Tata IND Security",
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
                          Navigator.pop(context);
                        },
                      ),
                      AlertButton(
                        isSelected: true,
                        text: 'Yes',
                        onPressed: () {
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
      elevation: 3,
      shape: isSelected
          ? OutlineInputBorder(
              borderRadius: BorderRadius.circular(7.w),
            )
          : null,
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
