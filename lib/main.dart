import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:isfa_crm/routes.dart';

import 'package:isfa_crm/utility/app_storage.dart';

void main() async {
  await AppStorage.objectValue();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return MaterialApp.router(
          routerConfig: router,
          title: const String.fromEnvironment('APP_NAME'),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              tabBarTheme: const TabBarTheme(
                labelColor: Colors.red,
                unselectedLabelColor: Colors.grey,
                dividerColor: Colors.white,
                indicator: BoxDecoration(color: Colors.white),
              ),
              colorScheme: ColorScheme.fromSeed(
                  seedColor: const Color(0xff437da6),
                  onSecondary: Colors.yellow)));
    });
  }
}
