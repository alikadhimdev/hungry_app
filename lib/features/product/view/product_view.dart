import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_text.dart';
import '../widgets/additional_card.dart';
import '../widgets/spice_slider.dart';

class ProductAdds {
  String title, img;
  ProductAdds({required this.title, required this.img});

  factory ProductAdds.fromJson(Map<String, dynamic> json) {
    return ProductAdds(title: json["title"], img: json["img"]);
  }
}

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  double spice = 0;

  List<ProductAdds> adds = [
    ProductAdds.fromJson({
      "title": "Tomato",
      "img": "assets/product/tomato.png",
    }),
    ProductAdds.fromJson({
      "title": "Onion",
      "img": "assets/product/onions.png",
    }),
    ProductAdds.fromJson({
      "title": "Pickles",
      "img": "assets/product/pickles.png",
    }),
    ProductAdds.fromJson({
      "title": "Bacons",
      "img": "assets/product/bacons.png",
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpiceSlider(
                value: spice,
                onChanged: (v) {
                  setState(() {
                    spice = v;
                  });
                },
              ),

              Gap(20),
              CustomText(text: "Toppings", weight: FontWeight.bold, size: 18),
              Gap(10),
              AdditionalCard(adds: adds),
              Gap(10),
              CustomText(
                text: "Side Options",
                weight: FontWeight.bold,
                size: 18,
              ),
              Gap(10),
              AdditionalCard(adds: adds),
              Gap(50),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Total",
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      Gap(5),
                      CustomText(
                        text: "\$ 18.19",
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomBottom(text: "Add To Cart"),
                ],
              ),
              Gap(500),
            ],
          ),
        ),
      ),
    );
  }
}
