import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PositionedSimplePopUp extends StatefulWidget {
  final Offset position;
  final Color? barrierColor;
  final Gradient? barrierGradient;
  final Widget content;

  const PositionedSimplePopUp({
    super.key,
    this.barrierColor,
    this.barrierGradient,
    required this.content,
    required this.position,
  });

  @override
  State<PositionedSimplePopUp> createState() => _PositionedSimplePopUpState();

  void show(BuildContext context) {
    Navigator.push(
      context,
      DialogRoute(
        context: context,
        barrierColor: Colors.transparent,
        builder: (context) => PositionedSimplePopUp(
          key: key,
          content: content,
          position: position,
          barrierColor: barrierColor,
          barrierGradient: barrierGradient,
        ),
      ),
    );
  }
}

class _PositionedSimplePopUpState extends State<PositionedSimplePopUp> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            onVerticalDragUpdate: (details) => Navigator.pop(context),
            child: Listener(
              onPointerSignal: (PointerSignalEvent event) {
                if (event is PointerScrollEvent) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: widget.barrierColor ?? Colors.black26,
                  gradient: widget.barrierGradient,
                ),
              ),
            ),
          ),
          Positioned(
            left: widget.position.dx,
            top: widget.position.dy,
            child: widget.content,
          ),
        ],
      ),
    );
  }
}
