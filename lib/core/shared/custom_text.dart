import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    super.key,
    required this.fontSize,
    this.fontWeight,
    this.color,
  });
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.w500,
        color: color ?? AppColors.white,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
