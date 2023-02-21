import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'auth_model.dart';
import 'auth_widget.dart';

abstract class IAuthWidgetModel extends IWidgetModel {
}

AuthWidgetModel defaultAuthWidgetModelFactory(BuildContext context) {
  return AuthWidgetModel(
    AuthModel(),
  );
}

// TODO: cover with documentation
/// Default widget model for AuthWidget
class AuthWidgetModel extends WidgetModel<AuthWidget, AuthModel>
    implements IAuthWidgetModel {

  AuthWidgetModel(AuthModel model) : super(model);
}
