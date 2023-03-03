import 'package:elementary/elementary.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class DefaultErrorHandler implements ErrorHandler {
  final Logger logger;

  const DefaultErrorHandler(this.logger);

  @override
  void handleError(
    Object error, {
    StackTrace? stackTrace,
    bool fatal = false,
  }) {
    if (!kIsWeb) {
      FirebaseCrashlytics.instance.recordError(
        error,
        stackTrace,
        fatal: fatal,
        printDetails: false,
      );
    }
    logger.e('Error occurred', error, stackTrace);
  }
}
