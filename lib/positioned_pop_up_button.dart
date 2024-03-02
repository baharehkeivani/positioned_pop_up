import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dialog_clip_rrect.dart';
import 'package:positioned_pop_up/positioned_simple_pop_up.dart';
import 'package:flutter_test/flutter_test.dart';

class PositionedPopUpButton extends StatefulWidget {
  final Widget button;
  final double? width;
  final double? height;
  final List<Widget> items;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool backgroundIsBlurred;
  final double spaceBetweenMenuAndButton;
  final EdgeInsetsGeometry? padding;

  const PositionedPopUpButton({
    super.key,
    required this.button,
    required this.items,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.backgroundColor,
    this.backgroundIsBlurred = false,
    this.spaceBetweenMenuAndButton = 8,
  });

  void showPopUpManually() {
    _PositionedPopUpButtonState().simulateTap();
  }

  @override
  State<PositionedPopUpButton> createState() => _PositionedPopUpButtonState();
}

class _PositionedPopUpButtonState extends State<PositionedPopUpButton> {
  late double _dialogPositionDy;
  late Size _buttonSize;
  late Offset _buttonPosition;
  final GlobalKey _buttonKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateButtonPosition();
    });
  }

  void _updateButtonPosition() {
    final RenderBox renderBox =
        _buttonKey.currentContext!.findRenderObject() as RenderBox;
    _buttonPosition = renderBox.localToGlobal(Offset.zero);
    _buttonSize = renderBox.size;
    _dialogPositionDy = _buttonPosition.dy +
        _buttonSize.height +
        widget.spaceBetweenMenuAndButton;
    if (!kIsWeb) {
      if (Platform.isIOS) {
        _dialogPositionDy -= AppBar().preferredSize.height;
      }
    }
    setState(() {});
  }

  double getButtonXPosition() {
    final leftWidth = _buttonPosition.dx + _buttonSize.width;
    if (leftWidth > MediaQuery.sizeOf(context).width) {
      return leftWidth;
    } else {
      return _buttonPosition.dx;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _buttonKey,
      onTap: () {
        _updateButtonPosition();
        PositionedSimplePopUp(
          position: Offset(
            getButtonXPosition(),
            _dialogPositionDy,
          ),
          barrierColor: Colors.transparent,
          content: DialogClipRRect(
            items: widget.items,
            padding: widget.padding,
            width: widget.width ?? 200,
            height: widget.height,
            borderRadius: widget.borderRadius,
            backgroundColor: widget.backgroundColor,
            backgroundIsBlurred: widget.backgroundIsBlurred,
          ),
        ).show(context);
      },
      child: widget.button,
    );
  }

  void simulateTap() {

    GestureBinding.instance.handlePointerEvent(
      PointerDownEvent(position: Offset(
        getButtonXPosition() + 1,
        _dialogPositionDy + 1,
      )),
    );


    // final gesture = TestWidgetsFlutterBinding.ensureInitialized();
    // Offset tapPosition = Offset(
    //   getButtonXPosition() + 1,
    //   _dialogPositionDy + 1,
    // );
    // final HitTestResult result = HitTestResult();
    // WidgetsBinding.instance.hitTestInView(result, tapPosition, 0);
    // gesture.dispatchEvent(
    //   PointerDownEvent(position: tapPosition, pointer: 1),
    //   result,
    // );
    // gesture.dispatchEvent(
    //   PointerUpEvent(position: tapPosition, pointer: 1),
    //   result,
    // );
  }
}
