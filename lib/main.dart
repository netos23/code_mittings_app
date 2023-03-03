import 'dart:async';

import 'package:code_mittings_app/domain/error/defaul_error_handler.dart';
import 'package:code_mittings_app/internal/app.dart';
import 'package:code_mittings_app/internal/app_dependency.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final logger = Logger();
  final errorHandler = DefaultErrorHandler(logger);

  FlutterError.onError = (details) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
    logger.e('Error occurred', details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    errorHandler.handleError(error, stackTrace: stack, fatal: true);
    return true;
  };

  runApp(
    AppDependency(
      app: FlameApp(),
    ),
  );
}
