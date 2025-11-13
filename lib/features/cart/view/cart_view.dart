import 'package:flutter/material.dart';

import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_text.dart';
import '../../checkout/view/checkout_view.dart';
import '../widgets/Cart_item.dart';
import '../data/items_data.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
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
            return CartItem(
              count: items[index].count,
              img: "assets/test/test.png",
              title: "Hamburger",
              des: "Veggle Burger",
              onAdd: () => setState(() {
                items[index].count++;
              }),
              onMinus: () => setState(() {
                if (items[index].count > 1) {
                  items[index].count--;
                }
              }),
              onRemove: () => setState(() {
                items.removeAt(index);
              }),
            );
          },
        ),
      ),

      bottomSheet: Container(
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
                CustomText(text: "Total", size: 20, weight: FontWeight.bold),
                CustomText(text: "\$ 18.19", size: 30, weight: FontWeight.bold),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutView()),
              ),
              child: CustomBottom(text: "Checkout", height: 50),
            ),
          ],
        ),
      ),
    );
  }
}
