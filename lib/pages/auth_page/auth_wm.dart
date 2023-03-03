import 'package:code_mittings_app/data/repository/user_repository.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth_model.dart';
import 'auth_page.dart';

abstract class IAuthWidgetModel extends IWidgetModel {
  AppLocalizations get localizations;

  void logIn();
}

AuthWidgetModel defaultAuthWidgetModelFactory(BuildContext context) {
  return AuthWidgetModel(
    AuthModel(),
  );
}

// TODO: cover with documentation
/// Default widget model for AuthWidget
class AuthWidgetModel extends WidgetModel<AuthPage, AuthModel>
    implements IAuthWidgetModel {
  AuthWidgetModel(AuthModel model) : super(model);

  @override
  late final AppLocalizations localizations;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    localizations = AppLocalizations.of(context);
  }

  @override
  Future<void> logIn() async {
  }

}
