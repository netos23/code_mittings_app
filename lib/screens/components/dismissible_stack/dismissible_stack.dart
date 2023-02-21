import 'dart:async';

import 'package:flutter/material.dart';

@Deprecated('Use DismissibleCardStack instead')
class DismissibleStack extends StatefulWidget {
  const DismissibleStack({super.key, required this.title});

  final String title;

  @override
  State<DismissibleStack> createState() => _DismissibleStackState();
}

class _DismissibleStackState extends State<DismissibleStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  final StreamController<Offset> _offsetController = StreamController();
  final StreamController<CardPresentationModel> _dataController =
      StreamController();
  final colors = const <CardModel>[
    CardModel(color: Colors.deepPurple, text: '1'),
    CardModel(color: Colors.amber, text: '2'),
    CardModel(color: Colors.lightGreen, text: '3'),
    CardModel(color: Colors.red, text: '4'),
  ];

  Offset? _start;
  Offset _lastUpdate = Offset.zero;
  double? _sign;
  bool _hasHorizontalDrag = false;
  bool _hasVerticalDrag = false;
  CardPresentationModel? currentModel;
  FinishResult? _result;

  @override
  void initState() {
    super.initState();
    _updateModel();
  }

  void _updateModel() {
    _result = null;
    if (currentModel == null) {
      currentModel = CardPresentationModel(
        current: colors[0],
        next: colors[1],
      );
    } else {
      currentModel = CardPresentationModel(
        current: currentModel!.next,
        next: colors[2],
      );
    }
    _dataController.add(currentModel!);
    _offsetController.add(Offset.zero);
  }

  @override
  void dispose() {
    _offsetController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _start ??= details.localPosition;
        _hasHorizontalDrag = true;
      },
      onVerticalDragStart: (details) {
        _start ??= details.localPosition;
        _hasVerticalDrag = true;
      },
      onHorizontalDragUpdate: (details) {
        final delta = details.localPosition - _start!;
        _sign ??= delta.dy.sign != 0 ? delta.dy.sign : 1;
        _lastUpdate = delta;
        _offsetController.add(delta);
      },
      onVerticalDragUpdate: (details) {
        final delta = details.localPosition - _start!;
        _sign ??= delta.dy.sign != 0 ? delta.dy.sign : 1;
        _lastUpdate = delta;
        _offsetController.add(delta);
      },
      onHorizontalDragEnd: (details) {
        _hasHorizontalDrag = false;
        _endDrag();
      },
      onVerticalDragEnd: (details) {
        _hasVerticalDrag = false;
        _endDrag();
      },
      child: LayoutBuilder(
        builder: (context, constrains) {
          return StreamBuilder(
            stream: _dataController.stream,
            builder: (context, dataSnapshot) {
              final data = dataSnapshot.data;
              if (data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return StreamBuilder(
                stream: _offsetController.stream,
                builder: (context, snapshot) {
                  final offset = snapshot.data ?? Offset.zero;
                  final sign = _sign ?? 1;
                  double rotation = sign * offset.dx / constrains.maxWidth;
                  final scale = 0.9 + 0.1 * rotation.abs();
                  return Stack(
                    key: ValueKey(data.current),
                    fit: StackFit.expand,
                    children: [
                      Positioned(
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                        child: AnimatedScale(
                          scale: scale.clamp(0, 1),
                          duration: const Duration(milliseconds: 300),
                          child: CodeCard(
                            color: data.next.color,
                            text: data.next.text,
                          ),
                        ),
                      ),
                      AnimatedPositionedDirectional(
                        duration: const Duration(milliseconds: 300),
                        width: constrains.maxWidth,
                        height: constrains.maxHeight,
                        top: offset.dy,
                        start: offset.dx,
                        onEnd: () {
                          _sign = null;
                          if (_result != null) {
                            _updateModel();
                          }
                        },
                        child: AnimatedRotation(
                          turns: rotation.clamp(-1, 1) / 8,
                          duration: const Duration(milliseconds: 300),
                          child: CodeCard(
                            color: data.current.color,
                            text: data.current.text,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  void _endDrag() {
    if (!_hasHorizontalDrag && !_hasVerticalDrag) {
      _start = null;
    }
  }
}

class CodeCard extends StatelessWidget {
  const CodeCard({
    super.key,
    required this.color,
    required this.text,
  });

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Center(
        child: Text(text),
      ),
    );
  }
}

class CardModel {
  final Color color;
  final String text;

  const CardModel({
    required this.color,
    required this.text,
  });
}

class CardPresentationModel {
  final CardModel current;
  final CardModel next;

  CardPresentationModel({
    required this.current,
    required this.next,
  });
}

enum FinishResult {
  top,
  bottom,
  left,
  right,
}
