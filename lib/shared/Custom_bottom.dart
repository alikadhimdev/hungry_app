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
  });
  final String text;
  final Function()? onTap;
  final double? vPadding;
  final double? hPadding;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: vPadding ?? 10,
          horizontal: hPadding ?? 20,
        ),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomText(
          text: text,
          color: Colors.white,
          size: 16,
          weight: weight ?? FontWeight.w500,
        ),
      ),
    );
  }
}
