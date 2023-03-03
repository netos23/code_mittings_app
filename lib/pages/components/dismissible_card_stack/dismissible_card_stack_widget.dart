import 'package:code_mittings_app/domain/entity/code_show_case.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'dismissible_card_stack_wm.dart';

// TODO: cover with documentation
/// Main widget for DismissibleCardStack module
class DismissibleCardStackWidget
    extends ElementaryWidget<IDismissibleCardStackWidgetModel> {
  const DismissibleCardStackWidget({
    Key? key,
    WidgetModelFactory wmFactory =
        defaultDismissibleCardStackWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IDismissibleCardStackWidgetModel wm) {
    return GestureDetector(
      onHorizontalDragStart: wm.onHorizontalDragStart,
      onHorizontalDragUpdate: wm.onHorizontalDragUpdate,
      onHorizontalDragEnd: wm.onHorizontalDragEnd,
      onVerticalDragStart: wm.onVerticalDragStart,
      onVerticalDragUpdate: wm.onVerticalDragUpdate,
      onVerticalDragEnd: wm.onVerticalDragEnd,
      child: ValueListenableBuilder(
        valueListenable: wm.animationState,
        builder: (context, animations, _) {
          return Stack(
            children: [
              Positioned.fill(
                child: ScaleTransition(
                  scale: animations.scaleAnimation,
                  child: EntityStateNotifierBuilder(
                    listenableEntityState: wm.nextCodeShowCaseState,
                    loadingBuilder: (context, _) {
                      return const Placeholder();
                    },
                    builder: (context, data) {
                      return CodeCard(
                        key: ValueKey(data!.id),
                        codeSowCase: data,
                      );
                    },
                  ),
                ),
              ),
              PositionedTransition(
                rect: animations.positionedAnimation,
                child: EntityStateNotifierBuilder(
                  listenableEntityState: wm.currentCodeShowCaseState,
                  loadingBuilder: (context, _) {
                    // todo(netos23): loading card
                    return const Placeholder();
                  },
                  builder: (context, data) {
                    return AnimatedRotation(
                      key: ValueKey(data!.id),
                      turns: animations.rotationAnimation,
                      duration: const Duration(milliseconds: 50),
                      child: CodeCard(
                        codeSowCase: data,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CodeCard extends StatelessWidget {
  const CodeCard({
    super.key,
    required this.codeSowCase,
  });

  final CodeSowCase codeSowCase;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: codeSowCase.color,
      child: Center(
        child: Text(codeSowCase.text),
      ),
    );
  }
}
