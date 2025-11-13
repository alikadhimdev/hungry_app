import 'package:flutter/material.dart';

import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_text.dart';
import '../widgets/Cart_item.dart';

class ItemCard {
  String img, title, des;
  int id, count;

  ItemCard({
    required this.img,
    required this.title,
    required this.des,
    required this.id,
    required this.count,
  });

  factory ItemCard.fromMap(Map<String, dynamic> map) {
    return ItemCard(
      img: map["img"],
      title: map["title"],
      des: map["des"],
      id: map["id"],
      count: map["count"],
    );
  }
}

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<ItemCard> items = [
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
    ItemCard(
      img: "assets/test/test.png",
      title: "Hamburger",
      des: "Veggle Burger",
      id: 1,
      count: 1,
    ),
  ];

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
            );
          },
        ),
      ),

      bottomSheet: Container(
        color: Colors.white,
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
            CustomBottom(text: "Checkout", hPadding: 30, vPadding: 15),
          ],
        ),
      ),
    );
  }
}
