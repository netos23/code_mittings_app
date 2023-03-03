import 'package:auto_route/auto_route.dart';
import 'package:code_mittings_app/pages/on_boarding_page/on_boarding_page_export.dart';
import 'package:code_mittings_app/pages/pages.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    onBoardingPageRoute,
    authRoute,
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
