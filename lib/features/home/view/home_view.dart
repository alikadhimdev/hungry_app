import 'package:flutter/material.dart';
import 'package:hungry_app/features/home/widgets/cart_item.dart';
import 'package:hungry_app/features/home/widgets/category_item.dart';
import 'package:hungry_app/features/home/widgets/search_bar.dart';
import 'package:hungry_app/features/home/widgets/user_header.dart';

class Item {
  int id;
  String title, des, rate, imgUrl;
  Item({
    required this.id,
    required this.title,
    required this.des,
    required this.rate,
    required this.imgUrl,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map["id"],
      title: map["title"],
      des: map["des"],
      rate: map["rate"],
      imgUrl: map["imgUrl"],
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> categories = ["All", "Combos", "Sliders", "Classic", "Modern"];
  int _selectedCategory = 0;

  List<Item> items = [
    Item(
      id: 1,
      title: "Cheeseburger",
      des: "Wendy's Burger",
      rate: "4.9",
      imgUrl: "assets/test/test.png",
    ),
    Item(
      id: 2,
      title: "Hamburger",
      des: "Veggie Burger",
      rate: "4.5",
      imgUrl: "assets/test/test1.png",
    ),
    Item(
      id: 3,
      title: "Cheeseburger",
      des: "Chicken Burger",
      rate: "4.7",
      imgUrl: "assets/test/test1.png",
    ),
    Item(
      id: 4,
      title: "Hamburger",
      des: "Fried Chicken Burger",
      rate: "4.0",
      imgUrl: "assets/test/test.png",
    ),
    Item(
      id: 5,
      title: "Cheeseburger",
      des: "Wendy's Burger",
      rate: "4.9",
      imgUrl: "assets/test/test.png",
    ),
    Item(
      id: 6,
      title: "Cheeseburger",
      des: "Wendy's Burger",
      rate: "4.9",
      imgUrl: "assets/test/test.png",
    ),
  ];

  Set<int> favoriteItems = {};

  void toggleFavorite(int itemId) {
    setState(() {
      if (favoriteItems.contains(itemId)) {
        favoriteItems.remove(itemId);
      } else {
        favoriteItems.add(itemId);
      }
    });
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
                  toolbarHeight: 135,
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
                      childCount: items.length,
                      (context, index) {
                        return CartItem(
                          title: items[index].title,
                          des: items[index].des,
                          rate: items[index].rate,
                          imgUrl: items[index].imgUrl,
                          isLike: favoriteItems.contains(items[index].id),
                          onFavorite: () {
                            toggleFavorite(items[index].id);
                          },
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
