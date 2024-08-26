import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';


class ShadowedContainer extends StatelessWidget {
  final Widget child;
  final double horizontalMargin;
  final double verticalMargin;
  final double verticalPadding;
  final double horizontalPadding;
  final double blurRadius;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  const ShadowedContainer(
      {super.key,
      required this.child,
      this.horizontalMargin = 25,
      this.verticalMargin = 0,
      this.blurRadius = 12,
      this.verticalPadding = 20,
      this.horizontalPadding = 25,
      this.color,this.margin,this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:margin?? EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      padding:padding?? EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: color?? Color(0xfffcfdf6),
        borderRadius: SmoothBorderRadius(
          cornerRadius: 15,
          cornerSmoothing: 1,
        ),
        border: Border.all(
          color: Colors.green.shade200,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade400,
            spreadRadius:.1 ,
            blurRadius: blurRadius,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}
