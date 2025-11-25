import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../shared/custom_text.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.orderPrice,
    required this.taxesPrice,
    required this.deliveryPrice,
    required this.time,
    required this.totalPrice,
  });

  final double taxesPrice, deliveryPrice, totalPrice, orderPrice;

  final String time;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: "Order summary", size: 18, weight: FontWeight.bold),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              checkoutWidget("order", orderPrice.toString(), false, false),
              Gap(5),
              checkoutWidget("Taxes", taxesPrice.toString(), false, false),

              Gap(5),
              checkoutWidget(
                "Delivery fees",
                orderPrice.toString(),
                false,
                false,
              ),

              Divider(color: Colors.grey.shade300),
              Gap(10),

              checkoutWidget("Total:", totalPrice.toString(), true, false),

              Gap(10),
              checkoutWidget("Estimated delivery time:", time, true, true),
            ],
          ),
        ),
      ],
    );
  }
}

Widget checkoutWidget(text, price, isBold, isSmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      CustomText(
        text: text,
        color: isBold ? Colors.black : Colors.grey.shade600,
        size: isSmall ? 12 : 16,
        weight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
      CustomText(
        text: "\$$price",
        color: isBold ? Colors.black : Colors.grey.shade600,
        size: isSmall ? 12 : 16,
        weight: isBold ? FontWeight.bold : FontWeight.normal,
      ),
    ],
  );
}
