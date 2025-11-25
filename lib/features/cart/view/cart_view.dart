import 'package:flutter/material.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';
import 'package:hungry_app/features/cart/data/cart_repo.dart';
import 'package:hungry_app/shared/custom_snack.dart';

import '../../../core/network/api_error.dart';
import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/view/checkout_view.dart';
import '../widgets/Cart_item.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  CartRepo cartRepo = CartRepo();
  List<CartItemModel> items = [];
  String totalPrice = "";

  Future<void> getCart() async {
    try {
      final cart = await cartRepo.getCart();
      if (cart == null) return;
      setState(() {
        items = cart.items ?? [];
        totalPrice = cart.totalPrice;
      });
    } catch (e) {
      String errMsg = "fail to get Cart";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      final response = await cartRepo.deleteItem(id);

      ScaffoldMessenger.of(context).showSnackBar(customSnack("Item deleted"));
      getCart();
    } catch (e) {
      String errMsg = "fail to get Cart";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  Future<void> updateItem(String id, int qyt) async {
    try {
      final response = await cartRepo.updateItem(id, qyt);

      setState(() {
        items = response!.items!;
        totalPrice = response.totalPrice;
      });
    } catch (e) {
      String errMsg = "fail to get Cart";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 100),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CartItem(
              count: item.qyt,
              img: item.image,
              title: item.name,
              des: "Veggle Burger",
              onAdd: () {
                if (item.qyt >= 1) {
                  updateItem(item.itemId, item.qyt + 1);
                }
              },
              onMinus: () {
                if (item.qyt > 1) {
                  updateItem(item.itemId, item.qyt - 1);
                }
              },
              onRemove: () => deleteItem(item.itemId),
            );
          },
        ),
      ),

      bottomSheet: items.isEmpty
          ? SizedBox()
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),

              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              height: 90,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total",
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      CustomText(
                        text: "\$$totalPrice",
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckoutView(
                          orderPrice: double.parse(totalPrice).toInt(),
                        ),
                      ),
                    ),
                    child: CustomBottom(text: "Checkout", height: 50),
                  ),
                ],
              ),
            ),
    );
  }
}
