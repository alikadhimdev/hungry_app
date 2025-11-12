import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/shared/custom_text.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.title,
    required this.des,
    required this.rate,
    required this.imgUrl,
  });

  final String title;
  final String des;
  final String rate;
  final String imgUrl;

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
            Center(child: Image.asset(imgUrl, width: 120, height: 110)),
            Gap(2),
            CustomText(text: title, weight: FontWeight.bold, size: 12),
            Gap(2),
            CustomText(text: des, size: 12),
            Gap(2),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                Gap(3),
                CustomText(text: rate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
