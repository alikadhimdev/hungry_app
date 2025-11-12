import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartItem extends StatefulWidget {
  const CartItem({
    super.key,
    required this.title,
    required this.des,
    required this.rate,
    required this.imgUrl,
    this.onFavorite,
    required this.isLike,
  });

  final String title;
  final String des;
  final String rate;
  final String imgUrl;
  final Function()? onFavorite;
  final bool isLike;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset(widget.imgUrl, width: 120, height: 110)),
            Gap(2),
            CustomText(text: widget.title, weight: FontWeight.bold, size: 12),
            Gap(2),
            CustomText(text: widget.des, size: 12),
            Gap(2),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Gap(3),
                CustomText(text: widget.rate),
                Spacer(),
                GestureDetector(
                  onTap: widget.onFavorite,
                  child: Icon(
                    widget.isLike
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.heart,
                    color: AppColors.primary,
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
