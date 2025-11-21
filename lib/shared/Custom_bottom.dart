import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import 'custom_text.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({
    super.key,
    required this.text,
    this.onTap,
    this.vPadding,
    this.hPadding,
    this.weight,
    this.width,
    this.color,
    this.height,
    this.textColor,
    this.radius,
  });
  final String text;
  final Function()? onTap;
  final double? vPadding;
  final double? hPadding;
  final FontWeight? weight;
  final double? width;
  final Color? color;
  final double? height;
  final Color? textColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(
          vertical: vPadding ?? 10,
          horizontal: hPadding ?? 20,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.primary,
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: textColor ?? Colors.white,
            size: 16,
            weight: weight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
