import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PositionedSimplePopUp extends StatefulWidget {
  final Offset position;
  final Color? barrierColor;
  final Gradient? barrierGradient;
  final Widget content;
  final void Function()? onClosePopUp;

  const PositionedSimplePopUp({
    super.key,
    this.barrierColor,
    this.barrierGradient,
    required this.content,
    required this.position,
    this.onClosePopUp,
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
          onClosePopUp: onClosePopUp,
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
            onTap: _onClose,
            onVerticalDragUpdate: (details) => _onClose(),
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

  void _onClose() {
    widget.onClosePopUp?.call();
    Navigator.pop(context);
  }
}
