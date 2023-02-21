import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:code_mittings_app/domain/error/defaul_error_handler.dart';
import 'package:code_mittings_app/screens/components/dismissible_card_stack/dismissible_card_stack_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    if (Platform.isAndroid || Platform.isIOS) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    }
    logger.e('Error occurred', details);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    errorHandler.handleError(error, stackTrace: stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Code mettings'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_fire_department_outlined,
              ),
              label: "Code",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.manage_accounts_outlined,
              ),
              label: "Proffile",
            ),
          ],
        ),
        body: TextButton(
          onPressed: () => throw Exception(),
          child: const Text("Throw Test Exception"),
        ),
      ),
    );
  }
}
