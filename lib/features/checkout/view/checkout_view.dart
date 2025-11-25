import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/features/cart/data/cart_repo.dart';
import 'package:hungry_app/features/checkout/widgets/success_widget.dart';
import 'package:hungry_app/features/order_history/data/order_model.dart';
import 'package:hungry_app/features/order_history/data/order_repo.dart';
import 'package:hungry_app/root.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/network/api_error.dart';
import "../../../shared/Custom_bottom.dart";
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../cart/data/cart_model.dart';
import '../widgets/order_details.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.orderPrice});
  final int orderPrice;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String? _paymentMethod = "cash";
  bool _saveCardInfo = false;
  double _orderPrice = 19.23;
  final double _fee = 0.3;
  final double _delivery = 1.5;
  double get _totalPrice => _orderPrice + _fee + _delivery;

  CartRepo cartRepo = CartRepo();
  OrderRepo orderRepo = OrderRepo();
  List<CartItemModel>? items = [];
  String totalPrice = "";

  Future<void> getCart() async {
    try {
      final cart = await cartRepo.getCart();
      if (cart == null) return;

      setState(() {
        items = cart.items;
        _orderPrice = double.parse(cart.totalPrice);
      });
    } catch (e) {
      String errMsg = "fail to get Cart";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  Future<void> addOrder() async {
    try {
      Map<String, dynamic> body = {
        "paymentMethod": _paymentMethod,
        "deliveryAddress": {"street": "my street", "city": "basra"},
        "notes": "this is my not",
        "items": items?.map((e) => e.toJson()).toList(),
      };

      final response = await orderRepo.addOrder(body);

      showDialog(context: context, builder: (context) => SuccessWidget());
    } catch (e) {
      String errMsg = "fail to add order";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  @override
  void initState() {
    getCart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => RootView()),
          ),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderDetails(
                orderPrice: _orderPrice,
                taxesPrice: _fee,
                deliveryPrice: _delivery,
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
              onTap: () {
                showDialog(
                  context: context,
                  builder: (v) {
                    return SuccessWidget();
                  },
                );
              },
              child: CustomBottom(onTap: addOrder, text: "Pay Now", height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
