import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'dialog_clip_rrect.dart';
import 'package:positioned_pop_up/positioned_simple_pop_up.dart';

class PositionedPopUpButton extends StatefulWidget {
  final Widget button;
  final double? width;
  final double? height;
  final List<Widget> items;
  final double? borderRadius;
  final bool showPopUpInPlace;
  final Color? backgroundColor;
  final bool backgroundIsBlurred;
  final EdgeInsetsGeometry? padding;
  final void Function()? onButtonTap;
  final void Function()? onClosePopUp;
  final double spaceBetweenMenuAndButton;
  final ScrollController? itemsScrollController;

  const PositionedPopUpButton({
    super.key,
    required this.button,
    required this.items,
    this.width,
    this.height,
    this.padding,
    this.onButtonTap,
    this.borderRadius,
    this.onClosePopUp,
    this.backgroundColor,
    this.itemsScrollController,
    this.showPopUpInPlace = false,
    this.backgroundIsBlurred = false,
    this.spaceBetweenMenuAndButton = 8,

  });

  void updatePopUp() {
    ((key as GlobalKey).currentState as _PositionedPopUpButtonState)
        .updatePopUp();
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
    if (widget.showPopUpInPlace) {
      _dialogPositionDy = _buttonPosition.dy;
    } else {
      _dialogPositionDy = _buttonPosition.dy +
          _buttonSize.height +
          widget.spaceBetweenMenuAndButton;
    }
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
      onTap: _onTap,
      child: widget.button,
    );
  }

  void _onTap() {
    _updateButtonPosition();
    widget.onButtonTap?.call();
    PositionedSimplePopUp(
      position: Offset(getButtonXPosition(), _dialogPositionDy),
      barrierColor: Colors.transparent,
      content: DialogClipRRect(
        items: widget.items,
        padding: widget.padding,
        width: widget.width ?? 200,
        height: widget.height,
        borderRadius: widget.borderRadius,
        backgroundColor: widget.backgroundColor,
        backgroundIsBlurred: widget.backgroundIsBlurred,
        itemsScrollController : widget.itemsScrollController,
      ),
      onClosePopUp: widget.onClosePopUp,
    ).show(context);
  }

  Future<void> updatePopUp() async {
    Navigator.pop(context);
    await Future.delayed(const Duration(milliseconds: 50));
    _onTap();
  }
}
