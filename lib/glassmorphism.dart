import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  final double opacity;
  final double height;
  final double width;
  final double blur;
  final Widget child;

  const GlassMorphism(
      {Key? key,
      required this.blur,
      required this.width,
      required this.height,
      required this.opacity,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(0.2),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(opacity),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(
              width: 1.5,
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
