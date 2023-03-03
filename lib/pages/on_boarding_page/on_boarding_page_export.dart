import 'package:auto_route/auto_route.dart';
import 'package:code_mittings_app/pages/page_routes.dart';

import 'on_boarding_page.dart';

export 'on_boarding_page.dart';

const onBoardingPageRoute = AutoRoute(
  page: OnBoardingPage,
  path: PageRoutes.onBoarding,
);
