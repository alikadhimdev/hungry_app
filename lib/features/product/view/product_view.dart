import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../core/network/api_error.dart';
import '../../../root.dart';
import '../../../shared/Custom_bottom.dart';
import '../../../shared/custom_snack.dart';
import '../../../shared/custom_text.dart';
import '../../cart/data/cart_repo.dart';
import '../../home/data/product_model.dart';
import '../../home/data/products_repo.dart';
import '../data/toppings_model.dart';
import '../widgets/additional_card.dart';
import '../widgets/spice_slider.dart';
import 'toppings_repo.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key, required this.id});
  final String id;

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductsRepo productsRepo = ProductsRepo();
  ToppingsRepo toppingsRepo = ToppingsRepo();
  CartRepo cartRepo = CartRepo();
  SideOptionsRepo sideOptionsRepo = SideOptionsRepo();
  double spice = 0;
  ProductModel? productModel;
  List<ToppingsModel>? toppingsList;
  List<SideOptionsModel>? sideOptionsList;
  Set<String> toppingsAdd = {};
  Set<String> sideOptionsAdd = {};

  int totalPrice = 0;

  Future<void> getProduct() async {
    try {
      final product = await productsRepo.getProduct(widget.id);
      if (product == null) return;
      setState(() {
        productModel = product;
        totalPrice = product.price;
      });
    } catch (e) {
      String errMsg = "fail to get products";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  Future<void> getToppings() async {
    try {
      final toppings = await toppingsRepo.getToppings();
      if (toppings == null) return;
      setState(() => toppingsList = toppings);
    } catch (e) {
      String errMsg = "fail to get toppings";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  Future<void> getSideOptions() async {
    try {
      final options = await sideOptionsRepo.getSideOptions();
      if (options == null) return;
      setState(() => sideOptionsList = options);
    } catch (e) {
      String errMsg = "fail to get side options";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  void addTopping(String id, int price) {
    setState(() {
      if (toppingsAdd.contains(id)) {
        toppingsAdd.remove(id);
        totalPrice -= price;
      } else {
        toppingsAdd.add(id);
        totalPrice += price;
      }
    });
    // print(totalPrice);
  }

  void addSideOptions(String id, int price) {
    setState(() {
      if (sideOptionsAdd.contains(id)) {
        sideOptionsAdd.remove(id);
        totalPrice -= price;
      } else {
        sideOptionsAdd.add(id);
        totalPrice += price;
      }
    });
  }

  Future<void> addToCart() async {
    try {
      final response = await cartRepo.addToCart(
        widget.id,
        spice,
        toppingsAdd.toList(),
        sideOptionsAdd.toList(),
      );
      if (response["status"] != 200 || response["success"] == "fail") {
        print(response["message"]);
        throw ApiError(message: response["message"]);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack("Added to cart Successfully"));
    } catch (e) {
      String errMsg = "fail to add to cart";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  @override
  void initState() {
    super.initState();
    getProduct();
    getToppings();
    getSideOptions();
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
              Row(
                children: List.generate(toppingsList?.length ?? 0, (index) {
                  final item = toppingsList![index];
                  return AdditionalCard(
                    isSelected: toppingsAdd.contains(item.id),
                    image: item.image ?? "",
                    name: item.name,
                    onTap: () {
                      addTopping(item.id, item.price);
                    },
                  );
                }),
              ),
              Gap(10),
              CustomText(
                text: "Side Options",
                weight: FontWeight.bold,
                size: 18,
              ),
              Gap(10),
              Row(
                children: List.generate(sideOptionsList?.length ?? 0, (index) {
                  final item = sideOptionsList![index];

                  return AdditionalCard(
                    image: item.image ?? "",
                    name: item.name,
                    isSelected: sideOptionsAdd.contains(item.id),
                    onTap: () {
                      addSideOptions(item.id, item.price);
                    },
                  );
                }),
              ),
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
                        text: "\$ $totalPrice",
                        size: 30,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomBottom(text: "Add To Cart", onTap: addToCart),
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
