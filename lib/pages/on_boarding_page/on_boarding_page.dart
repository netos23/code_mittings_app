import 'package:auto_route/auto_route.dart';
import 'package:code_mittings_app/pages/components/components.dart';
import 'package:code_mittings_app/pages/page_routes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:code_mittings_app/assets/resourses.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final pages = [
      _ImageWithTextPage(
        picture: Resources.happyFlame,
        description: localizations.welcomePage,
      ),
      _ImageWithTextPage(
        picture: Resources.swipe,
        description: localizations.tutorialPage,
      ),
      const _GetStartedPage(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 10,
            child: PageView(
              controller: _controller,
              children: pages,
            ),
          ),
          Expanded(
            child: _PaginationDots(
              pageController: _controller,
              length: pages.length,
            ),
          ),
        ],
      ),
    );
  }
}

class _PaginationDots extends StatelessWidget {
  const _PaginationDots({
    Key? key,
    required this.pageController,
    required this.length,
  }) : super(key: key);

  final PageController pageController;
  final int length;

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    // todo(netos23): upgrade animation
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, _) {
        final page = pageController.page ?? 0;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(length, (index) {
            final isActive = page.round() == index;
            return Flexible(
              child: Container(
                width: isActive ? 30 : 25,
                height: isActive ? 30 : 25,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? colorTheme.primary : colorTheme.secondary,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _ImageWithTextPage extends StatelessWidget {
  const _ImageWithTextPage({
    Key? key,
    required this.picture,
    required this.description,
  }) : super(key: key);

  final String picture;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Image.asset(picture),
        ),
        Flexible(
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _GetStartedPage extends StatelessWidget {
  const _GetStartedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Flexible(
          flex: 5,
          child: NamedLogo(),
        ),
        Flexible(
          child: Text(
            localizations.getStartedPage,
            textAlign: TextAlign.center,
          ),
        ),
        Flexible(
          child: OutlinedButton(
            onPressed: () => context.router.root.replaceNamed(
              PageRoutes.auth,
            ),
            child: Text(
              localizations.startUsing,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
