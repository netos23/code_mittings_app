import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'auth_wm.dart';

// TODO: cover with documentation
/// Main widget for Auth module
class AuthWidget extends ElementaryWidget<IAuthWidgetModel> {
  const AuthWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultAuthWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAuthWidgetModel wm) {
    return Container();
  }
}
