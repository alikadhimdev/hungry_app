import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.img,
    required this.title,
    required this.des,
    this.onAdd,
    this.onMinus,
    this.onRemove,
    required this.count,
  });

  final int count;
  final String img;
  final String title;
  final String des;
  final Function()? onAdd;
  final Function()? onMinus;
  final Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(img, width: 110),

                CustomText(text: title, weight: FontWeight.bold),
                CustomText(text: des),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: onMinus,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.minus, color: Colors.white),
                      ),
                    ),
                    Gap(20),
                    CustomText(
                      text: count.toString(),
                      size: 25,
                      weight: FontWeight.bold,
                    ),
                    Gap(20),

                    GestureDetector(
                      onTap: onAdd,
                      child: CircleAvatar(
                        backgroundColor: AppColors.primary,
                        child: Icon(CupertinoIcons.add, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                GestureDetector(
                  onTap: onRemove,
                  child: CustomBottom(
                    text: "Remove",
                    hPadding: 40,
                    vPadding: 5,
                    weight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
