import 'package:flutter/material.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/home/data/product_model.dart';
import 'package:hungry_app/features/home/data/products_repo.dart';
import 'package:hungry_app/shared/custom_snack.dart';

import '../../product/view/product_view.dart';
import '../widgets/cart_item.dart';
import '../widgets/category_item.dart';
import '../widgets/search_bar.dart';
import '../widgets/user_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = ["All", "Combos", "Sliders", "Classic", "Modern"];
  int _selectedCategory = 0;

  List<ProductModel>? items;
  Set<String> favoriteItems = {};

  void toggleFavorite(String itemId) {
    setState(() {
      if (favoriteItems.contains(itemId)) {
        favoriteItems.remove(itemId);
      } else {
        favoriteItems.add(itemId);
      }
    });
  }

  ProductsRepo productsRepo = ProductsRepo();

  Future<void> getProducts() async {
    try {
      final products = await productsRepo.getProducts();
      setState(() => items = products);
    } catch (e) {
      String errMsg = "fail to get products";
      if (e is ApiError) {
        errMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
    }
  }

  @override
  void initState() {
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),

      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  shadowColor: Colors.black,
                  toolbarHeight: 140,
                  scrolledUnderElevation: 0,
                  flexibleSpace: Column(
                    children: [UserHeader(), SearchBarHome()],
                  ),
                ),

                SliverToBoxAdapter(
                  child: CategoryItem(
                    selectedIndex: _selectedCategory,
                    categories: categories,
                  ),
                ),

                SliverPadding(
                  padding: EdgeInsets.only(top: 15),

                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      childCount: items?.length,
                      (context, index) {
                        if (items == null) return Container();
                        final item = items![index];
                        return GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (c) => ProductView(id: item.id),
                            ),
                          ),
                          child: CartItem(
                            title: item.name,
                            des: item.des,
                            rate: item.rate.toString(),
                            imgUrl: item.image,
                            isLike: favoriteItems.contains(item.id),
                            onFavorite: () {
                              toggleFavorite(item.id);
                            },
                          ),
                        );
                      },
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
