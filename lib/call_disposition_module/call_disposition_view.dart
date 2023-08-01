import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/accounts_module/models/call_data.dart';
import 'package:isfa_crm/call_disposition_module/callBloc/call_bloc.dart';

import 'package:isfa_crm/call_disposition_module/call_model.dart';
import 'package:isfa_crm/call_disposition_module/call_repository.dart';

class CallDisposition extends StatefulWidget {
  final CallData callData;
  const CallDisposition(this.callData, {super.key});

  @override
  State<CallDisposition> createState() => _CallDispositionState();
}

class _CallDispositionState extends State<CallDisposition> {
  String? callStatusValue;
  String? callSubStatusValue;
  ContactStatusList? contactStatusValue;

  List<String>? callStatusList;
  List<ContactStatusList>? contactStatusList;
  List<String>? callSubStatusList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Disposition"),
      ),
      body: RepositoryProvider(
        create: (context) => CallRepository(),
        child: BlocProvider(
          create: (context) => CallBloc(context.read(), widget.callData)
            ..add(ShowCallStatusListEvent()),
          child: BlocConsumer<CallBloc, CallState>(
            listener: (context, state) {},
            builder: (context, state) {
              var bloc = context.read<CallBloc>();
              if (state is ShowCallStatusListState) {
                callStatusList = bloc.callStatus;
              }
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                                      onTap: () {
                                        if (state
                                            is ShowContactStatusListState) {
                                        } else {
                                          contactStatusValue = null;
                                        }
                                      },
                                      hint: const Text(
                                        "Select..",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      isExpanded: true,
                                      value: callStatusValue,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      dropdownColor:
                                          Theme.of(context).colorScheme.primary,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items:
                                          callStatusList?.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(items),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        callStatusValue = newValue;
                                        bloc.add(OnChangeCallStatusEvent());
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
                                      onTap: () {
                                        callSubStatusValue = null;
                                      },
                                      hint: const Text(
                                        "Select..",
                                        style: TextStyle(color: Colors.white70),
                                      ),
                                      isExpanded: true,
                                      value: contactStatusValue,
                                      iconEnabledColor: Colors.white,
                                      iconDisabledColor: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 18),
                                      dropdownColor: Colors.black,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      items: bloc.contactStatus
                                          ?.map((ContactStatusList items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(items.contactStatus),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (ContactStatusList? newValue) {
                                        contactStatusValue = newValue;
                                        bloc.add(OnChangeContactStatusEvent(
                                            newValue?.id ?? -1));
                                      },
                                    ),
                                  ),
                                ]),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        if (state is ShowCallSubStatusListState ||
                            state is OnChangeCallSubStatusState)
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
                                        hint: const Text(
                                          "Select..",
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        isExpanded: true,
                                        value: callSubStatusValue,
                                        iconEnabledColor: Colors.white,
                                        iconDisabledColor: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 18),
                                        dropdownColor: Colors.black,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        items: bloc.callSubStatus
                                            ?.map((String items) {
                                          return DropdownMenuItem(
                                            value: items,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(items),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? newValue) {
                                          callSubStatusValue = newValue;
                                          bloc.add(
                                              OnChangeCallSubStatusEvent());
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Remarks",
                                        style: TextStyle(fontSize: 15.sp),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.mic,
                                            color: Colors.red),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      cursorColor: Colors.white,
                                      style: TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          disabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.white)),
                                          hintText: "Remarks",
                                          hintStyle:
                                              TextStyle(color: Colors.white70)),
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
                              onPressed: () {
                                debugPrint(
                                    "${contactStatusValue?.contactStatus} $callStatusValue $callSubStatusValue");
                              },
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
              );
            },
          ),
        ),
      ),
    );
  }
}
