import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  const CircularContainer({
    super.key,
    this.child,

    //this.widthFactor = 0.5,
    //this.heightFactor = 0.5,
    this.radius = 400,
    this.padding = 0,
    this.backgroundColor = const Color(0xFF1E293B),
    required this.width,
    required this.height,
    this.margin,
  });

  final double width;
  final double height;

  final double radius;
  final double padding;
  final Widget? child;
  final Color backgroundColor;
  final EdgeInsets? margin;
  //final double widthFactor;
  //final double heightFactor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
