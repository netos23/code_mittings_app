import 'package:code_mittings_app/assets/resourses.dart';
import 'package:code_mittings_app/pages/components/components.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'auth_wm.dart';

// TODO: cover with documentation
/// Main widget for Auth module
class AuthPage extends ElementaryWidget<IAuthWidgetModel> {
  const AuthPage({
    Key? key,
    WidgetModelFactory wmFactory = defaultAuthWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IAuthWidgetModel wm) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              flex: 5,
              child: NamedLogo(),
            ),
            Flexible(
              child: Text(
                wm.localizations.authNotify,
              ),
            ),
             Flexible(
              child: _AuthButton(
                onTap: wm.logIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthButton extends StatelessWidget {
  const _AuthButton({
    super.key,
    this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return SizedBox(
      height: 50,
      child: FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          backgroundColor: Colors.black,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SvgPicture.asset(
                Resources.gitHubLogo,
                height: 25,
                width: 25,
                color: Colors.white,
              ),
            ),
            const Flexible(
              child: VerticalDivider(
                indent: 5,
                endIndent: 5,
                color: Colors.white,
              ),
            ),
            Flexible(
              child: Text(
                localizations.logInWithGitHub,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
