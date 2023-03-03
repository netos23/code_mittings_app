import 'package:auto_route/auto_route.dart';
import 'package:code_mittings_app/assets/theme/app_theme.dart';
import 'package:code_mittings_app/internal/app_router.dart';
import 'package:code_mittings_app/pages/auth_page/auth_page_export.dart';
import 'package:code_mittings_app/pages/on_boarding_page/on_boarding_page_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class FlameApp extends StatelessWidget {
  FlameApp({
    Key? key,
    this.firstLaunch = false,
  }) : super(key: key);

  final _appRouter = AppRouter();
  final bool firstLaunch;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flame',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: context.watch<AppThemeWrapper>().colorScheme,
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(
        initialRoutes:  [
          const OnBoardingRoute(),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
