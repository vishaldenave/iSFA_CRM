import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isfa_crm/accounts_module/models/call_data.dart';
import 'package:isfa_crm/call_disposition_module/call_disposition_view.dart';
import 'package:isfa_crm/login_module/login_view.dart';
import 'package:isfa_crm/tabbar/tabbar_view.dart';
import 'package:isfa_crm/utility/app_storage.dart';

final router = GoRouter(
  initialLocation: AppPaths.initial,
  routes: <RouteBase>[
    GoRoute(
      path: AppPaths.initial,
      name: AppPaths.initial,
      builder: (context, state) => AppStorage().userDetail != null
          ? const TabbarView()
          : const LoginView(),
    ),
    GoRoute(
      path: AppPaths.tabbar,
      name: AppPaths.tabbar,
      builder: (context, state) => const TabbarView(),
    ),
    GoRoute(
      path: AppPaths.pinset,
      name: AppPaths.pinset,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppPaths.callDisposition,
      name: AppPaths.callDisposition,
      builder: (context, state) => CallDisposition(state.extra as CallData),
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: Center(
        child: Text(state.fullPath ??
            state.error?.toString() ??
            state.name ??
            "unknown error"),
      ),
    );
  },
);

class AppPaths {
  static const initial = '/';
  static const tabbar = '/tabbar';
  static const pinset = '/pinset';
  static const callDisposition = '/calldisposition';
}
