import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallDisposition extends StatefulWidget {
  const CallDisposition({super.key});

  @override
  State<CallDisposition> createState() => _CallDispositionState();
}

class _CallDispositionState extends State<CallDisposition> {
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Disposition"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call Status",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          dropdownColor: Colors.black,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // setState(() {
                            //   dropdownvalue = newValue!;
                            // });
                          },
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Contact Status",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          dropdownColor: Colors.black,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // setState(() {
                            //   dropdownvalue = newValue!;
                            // });
                          },
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Call Sub Status",
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButton(
                          isExpanded: true,
                          value: dropdownvalue,
                          iconEnabledColor: Colors.white,
                          iconDisabledColor: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                          dropdownColor: Colors.black,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(items),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            // setState(() {
                            //   dropdownvalue = newValue!;
                            // });
                          },
                        ),
                      ),
                    ]),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remarks",
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          IconButton(
                            icon: const Icon(Icons.mic, color: Colors.red),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      Container(
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Remarks",
                            ),
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            SizedBox(height: 18.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  padding: const EdgeInsets.all(18),
                  onPressed: () {},
                  color: Colors.amber[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("SAVE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15)),
                ),
                SizedBox(width: 15.w),
                MaterialButton(
                  padding: const EdgeInsets.all(18),
                  onPressed: () {},
                  color: Colors.greenAccent[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text("SUBMIT",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15)),
                ),
              ],
            ),
            SizedBox(height: 20.h)
          ]),
        ),
      ),
    );
  }
}
