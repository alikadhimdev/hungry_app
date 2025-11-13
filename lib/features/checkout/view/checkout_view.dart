import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../core/constants/app_colors.dart';
import "../../../shared/Custom_bottom.dart";
import '../../../shared/custom_text.dart';
import '../widgets/order_details.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? _paymentMethod = "cash";
  bool _saveCardInfo = false;
  double _totalPrice = 19.23;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetails(
                orderPrice: 16.48,
                taxesPrice: 0.3,
                deliveryPrice: 1.5,
                totalPrice: _totalPrice,
                time: "3 - 5 Minutes",
              ),
              Gap(30),
              CustomText(
                text: "Payment methods",
                size: 18,
                weight: FontWeight.bold,
              ),
              Gap(10),

              GestureDetector(
                onTap: () => setState(() => _paymentMethod = "cash"),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Color(0xff3C2F2F),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Image.asset("assets/checkout/dollar.png"),
                    title: CustomText(
                      text: "Cash on Delivery",
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                    trailing: Radio(
                      activeColor: Colors.white,

                      value: "cash",
                      groupValue: _paymentMethod,
                      onChanged: (v) {},
                    ),
                  ),
                ),
              ),
              Gap(20),
              GestureDetector(
                onTap: () => setState(() => _paymentMethod = "visa"),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Image.asset("assets/checkout/visa.png", width: 80),
                    title: CustomText(
                      text: "Debit card",
                      weight: FontWeight.w700,
                    ),
                    subtitle: CustomText(text: "3566 **** **** 0505", size: 12),
                    trailing: Radio(
                      activeColor: AppColors.primary,
                      value: "visa",
                      groupValue: _paymentMethod,
                      onChanged: (v) => setState(() => _paymentMethod = v),
                    ),
                  ),
                ),
              ),
              Gap(20),

              Row(
                children: [
                  Checkbox(
                    activeColor: Colors.red,
                    value: _saveCardInfo,
                    onChanged: (v) {
                      setState(() => _saveCardInfo = !_saveCardInfo);
                    },
                  ),
                  CustomText(
                    text: "Save card details for future payments",
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
              Gap(300),
            ],
          ),
        ),
      ),

      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 20, offset: Offset(0, 1)),
          ],
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Total", size: 18, weight: FontWeight.bold),
                CustomText(
                  text: "\$ $_totalPrice",
                  size: 25,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutView()),
              ),
              child: CustomBottom(text: "Pay Now", height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
