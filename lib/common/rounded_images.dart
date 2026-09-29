import 'package:flutter/material.dart';

class Rounded_image extends StatelessWidget {
  const Rounded_image({
    super.key,
    this.width = 40,
    this.height = 60,
    this.applyImageRadius = false ,
    this.border,
    this.backgroundColor = Colors.black ,
    this.fit = BoxFit.contain,
    this.padding,
    required this.imgURl,
    this.onPressed, 
    this.borderRadius = 8,
  });

  final double? width, height;
  final String imgURl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  //final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),

          child: Image.network(imgURl, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
