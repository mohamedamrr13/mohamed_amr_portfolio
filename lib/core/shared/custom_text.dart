// lib/core/shared/custom_text.dart - Enhanced with theme support
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool useThemeColor;

  const CustomText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.useThemeColor = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        Color textColor;

        if (color != null) {
          textColor = color!;
        } else if (useThemeColor) {
          textColor =
              themeProvider.isDarkMode ? AppColors.white : AppColors.darkText;
        } else {
          textColor = AppColors.white;
        }

        return AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          style: TextStyle(
            fontSize: fontSize ?? 16,
            fontWeight: fontWeight ?? FontWeight.normal,
            color: textColor,
            fontFamily: 'SpaceGrotesk',
            height: 1.4,
          ),
          child: Text(
            text,
            textAlign: textAlign,
            maxLines: maxLines,
            overflow: overflow,
          ),
        );
      },
    );
  }
}
