import 'dart:ui';

import 'package:flutter/material.dart';

class DialogClipRRect extends StatelessWidget {
  final double width;
  final double? height;
  final List<Widget> items;
  final double? borderRadius;
  final Color? backgroundColor;
  final bool backgroundIsBlurred;
  final EdgeInsetsGeometry? padding;
  final ScrollController? itemsScrollController;

  const DialogClipRRect({
    super.key,
    this.height,
    this.padding,
    required this.width,
    required this.items,
    this.backgroundColor,
    this.borderRadius = 12,
    this.itemsScrollController,
    this.backgroundIsBlurred = false,
  });

  @override
  Widget build(BuildContext context) {
    double blurAmount = backgroundIsBlurred ? 100 : 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundIsBlurred
                ? (backgroundColor ?? Colors.white).withOpacity(0.1)
                : (backgroundColor ?? Colors.white),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
          child: ListView(
            controller: itemsScrollController,
            shrinkWrap: true,
            padding: padding,
            children: items,
          ),
        ),
      ),
    );
  }
}
