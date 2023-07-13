import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  bool isAccountNameSelecting = false;
  bool showContants = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Accounts"),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 0),
          elevation: 2,
          child: ListTile(
            onTap: () {
              isAccountNameSelecting = !isAccountNameSelecting;
              showContants = false;
              setState(() {});
            },
            title: const Text("Account Name"),
            subtitle: const Text("Select"),
            trailing: Icon(isAccountNameSelecting
                ? Icons.keyboard_arrow_up
                : Icons.keyboard_arrow_down),
          ),
        ),
        if (isAccountNameSelecting)
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
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 200.h,
                      child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) => SizedBox(
                          height: 30.h,
                          child: ListTile(
                            onTap: () {
                              showContants = true;
                              isAccountNameSelecting = false;
                              setState(() {});
                            },
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              "Some dummy text here...",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 13.sp),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        if (showContants)
          Expanded(
            child: ListView.separated(
                itemCount: 3,
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
                          "Sumit Sharma",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Director & Chief Executive Officer"),
                            Text("+001-344-123456")
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(100)),
                          child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.call,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    )),
          )
      ]),
    );
  }
}
