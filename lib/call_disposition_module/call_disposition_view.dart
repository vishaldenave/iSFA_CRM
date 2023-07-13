import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallDisposition extends StatefulWidget {
  const CallDisposition({super.key});

  @override
  State<CallDisposition> createState() => _CallDispositionState();
}

class _CallDispositionState extends State<CallDisposition> {
  bool isCallStatusSelecting = false;
  bool showContents = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Disposition"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Call Status",
                      style: TextStyle(fontSize: 15.sp),
                    ),
                    Card(
                      color: Colors.blue,
                      margin: EdgeInsets.fromLTRB(0, 20.w, 0, 0),
                      elevation: 2,
                      child: ListTile(
                        onTap: () {
                          isCallStatusSelecting = !isCallStatusSelecting;
                          showContents = false;
                          setState(() {});
                        },
                        title: const Text(
                          "Effective",
                          style: TextStyle(color: Colors.white),
                        ),
                        trailing: Icon(
                            isCallStatusSelecting
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: Colors.white),
                      ),
                    ),
                  ]),
            ),
          )
        ]),
      ),
    );
  }
}
