
import 'package:code_mittings_app/utill/theme_extensions.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemeWrapper extends ChangeNotifier {
  final lightColorScheme = const ColorScheme.light(
    primary: logoColor3,
    secondary: logoColor6,
    secondaryContainer: logoColor4,
    onSecondaryContainer: Colors.white,
  );
  final darkColorScheme = const ColorScheme.dark(
    secondaryContainer: logoColor4,
    onSecondaryContainer: Colors.white,
  );

  AppThemeWrapper({
    Brightness brightness = Brightness.light,
  }) : _brightness = brightness;

  Brightness _brightness;

  ColorScheme get colorScheme =>
      _brightness.isLight ? lightColorScheme : darkColorScheme;

  set brightness(Brightness value) {
    if (_brightness != value) {
      _brightness = value;
      notifyListeners();
    }
  }

  Brightness get brightness => _brightness;

  void toggleTheme() {
    _brightness = _brightness.invert;
    notifyListeners();
  }
}
