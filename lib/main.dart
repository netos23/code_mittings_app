import 'dart:async';

import 'package:code_mittings_app/screens/components/dismissible_card_stack/dismissible_card_stack_widget.dart';
import 'package:flutter/material.dart';

void main() {
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
        body: const DismissibleCardStackWidget(),
      ),
    );
  }
}
