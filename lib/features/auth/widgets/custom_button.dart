import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CustomAuthButton extends StatelessWidget {
  const CustomAuthButton({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.onTap,
    this.textColor,
  });

  final String text;
  final Color? color;
  final Color? textColor;
  final double? size;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: textColor ?? AppColors.primary, width: 1),
        ),
        child: Center(
          child: CustomText(
            text: text,
            weight: FontWeight.w700,
            size: 18,
            color: textColor ?? AppColors.primary,
          ),
        ),
      ),
    );
  }
}
