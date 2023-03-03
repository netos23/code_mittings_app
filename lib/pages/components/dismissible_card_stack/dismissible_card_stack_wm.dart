import 'package:code_mittings_app/domain/entity/code_show_case.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dismissible_card_animation_model.dart';
import 'dismissible_card_stack_model.dart';
import 'dismissible_card_stack_widget.dart';

abstract class IDismissibleCardStackWidgetModel extends IWidgetModel {
  ValueListenable<DismissibleCardAnimationModel> get animationState;

  EntityStateNotifier<CodeSowCase> get currentCodeShowCaseState;

  EntityStateNotifier<CodeSowCase> get nextCodeShowCaseState;

  void onHorizontalDragStart(DragStartDetails details);

  void onHorizontalDragUpdate(DragUpdateDetails details);

  void onHorizontalDragEnd(DragEndDetails details);

  void onVerticalDragStart(DragStartDetails details);

  void onVerticalDragUpdate(DragUpdateDetails details);

  void onVerticalDragEnd(DragEndDetails details);
}

DismissibleCardStackWidgetModel defaultDismissibleCardStackWidgetModelFactory(
    BuildContext context) {
  return DismissibleCardStackWidgetModel(
    DismissibleCardStackModel(
        //todo(netos23): enable exception handler
        // errorHandler: context.read(),
        ),
  );
}

// TODO: cover with documentation
/// Default widget model for DismissibleCardStackWidget
class DismissibleCardStackWidgetModel
    extends WidgetModel<DismissibleCardStackWidget, DismissibleCardStackModel>
    with SingleTickerProviderWidgetModelMixin
    implements IDismissibleCardStackWidgetModel {
  @override
  final currentCodeShowCaseState = EntityStateNotifier<CodeSowCase>();

  @override
  final nextCodeShowCaseState = EntityStateNotifier<CodeSowCase>();

  @override
  late final ValueNotifier<DismissibleCardAnimationModel> animationState;

  late final AnimationController _animationController;
  Offset? _start;
  Offset _lastUpdate = Offset.zero;
  double? _sign;
  bool _hasHorizontalDrag = false;
  bool _hasVerticalDrag = false;

  DismissibleCardStackWidgetModel(super.model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addStatusListener(_listenStatus);

    animationState = ValueNotifier(
      _buildAnimations(
        Offset.zero,
      ),
    );

    currentCodeShowCaseState.content(
      CodeSowCase(
        id: 0,
        color: Colors.deepPurple,
        text: '1',
      ),
    );
    nextCodeShowCaseState.content(
      CodeSowCase(
        id: 1,
        color: Colors.amber,
        text: '2',
      ),
    );
  }

  DismissibleCardAnimationModel _buildAnimations([Offset? initialOffset]) {
    final offset = initialOffset ?? _lastUpdate;

    final width = MediaQuery.of(context).size.width;
    final sign = _sign ?? 1;
    final rotation = (sign * offset.dx / width).clamp(-1, 1);
    final scale = 0.9 + 0.1 * rotation.abs();
    final endOffset = _determineEndOffset(offset);


    final positionedAnimation = RelativeRectTween(
      begin: RelativeRect.fill.shift(offset),
      end: RelativeRect.fill.shift(endOffset),
    ).animate(
      _animationController,
    );

    final scaleAnimation = Tween<double>(
      begin: scale,
      end: 1,
    ).animate(
      _animationController,
    );

    return DismissibleCardAnimationModel(
      rotationAnimation:  rotation / 8,
      positionedAnimation: positionedAnimation,
      scaleAnimation: scaleAnimation,
    );
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(_listenStatus);
    _animationController.dispose();
    nextCodeShowCaseState.dispose();
    currentCodeShowCaseState.dispose();
    animationState.dispose();
    super.dispose();
  }

  Offset _determineEndOffset(Offset lastUpdate) {
    final size = MediaQuery.of(context).size;

    if (lastUpdate.dx > 100) {
      return Offset(2 * size.width, 100);
    } else if (lastUpdate.dx < -100) {
      return Offset(-2 * size.width, 100);
    } else if (lastUpdate.dy > 100) {
      return Offset(0, 2 * size.height);
    } else if (lastUpdate.dy < -100) {
      return Offset(0, -2 * size.height);
    }

    return Offset.zero;
  }

  void _releaseCard() {
    if (!_hasVerticalDrag && !_hasHorizontalDrag) {
      _start = null;
      _animationController.forward();
    }
  }

  @override
  void onHorizontalDragEnd(DragEndDetails details) {
    _hasHorizontalDrag = false;
    _releaseCard();
  }

  @override
  void onHorizontalDragStart(DragStartDetails details) {
    _start ??= details.localPosition;
    _hasHorizontalDrag = true;
  }

  @override
  void onHorizontalDragUpdate(DragUpdateDetails details) {
    final delta = details.localPosition - _start!;
    _sign ??= delta.dy.sign != 0 ? delta.dy.sign : 1;
    _lastUpdate = delta;
    animationState.value = _buildAnimations();
  }

  @override
  void onVerticalDragEnd(DragEndDetails details) {
    _hasVerticalDrag = false;
    _releaseCard();
  }

  @override
  void onVerticalDragStart(DragStartDetails details) {
    _start ??= details.localPosition;
    _hasVerticalDrag = true;
  }

  @override
  void onVerticalDragUpdate(DragUpdateDetails details) {
    final delta = details.localPosition - _start!;
    _sign ??= delta.dy.sign != 0 ? delta.dy.sign : 1;
    _lastUpdate = delta;
    animationState.value = _buildAnimations();
  }

  void _listenStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animationController.reset();
      _sign = null;
      animationState.value = _buildAnimations(Offset.zero);
    }
  }
}
