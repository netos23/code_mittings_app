import 'package:auto_route/auto_route.dart';
import 'package:code_mittings_app/pages/page_routes.dart';

import 'auth_page.dart';

export 'auth_page.dart';
export 'auth_model.dart';
export 'auth_wm.dart';

const authRoute = AutoRoute(
  page: AuthPage,
  path: PageRoutes.auth,
);
