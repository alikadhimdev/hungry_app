import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/app_colors.dart';
import '../../../shared/custom_text.dart';

class SpiceSlider extends StatelessWidget {
  const SpiceSlider({super.key, required this.value, this.onChanged});
  final double value;
  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset("assets/product/product.png", height: 200),
        Spacer(),
        Column(
          children: [
            CustomText(
              lines: 3,
              size: 14,
              text:
                  "Customize Your Burger\nto Your Tastes. Ultimate\nExperience",
            ),
            Gap(20),
            Slider(
              label: "Spice",
              activeColor: AppColors.primary,
              min: 0,
              max: 1,
              value: value,
              onChanged: onChanged,
            ),
            Row(
              children: [
                CustomText(text: "🥶"),
                Gap(100),
                CustomText(text: "🌶️"),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
