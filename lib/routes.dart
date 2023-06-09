import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:isfa_crm/tabbar/tabbar_view.dart';

final router = GoRouter(
  initialLocation: AppPaths.initial,
  routes: <RouteBase>[
    GoRoute(
      path: AppPaths.initial,
      name: AppPaths.initial,
      builder: (context, state) => const TabbarView(),
    ),
    GoRoute(
      path: AppPaths.tabbar,
      name: AppPaths.tabbar,
      builder: (context, state) => const TabbarView(),
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
}
