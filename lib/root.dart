import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/profile_view.dart';
import 'package:hungry_app/features/cart/view/cart_view.dart';
import 'package:hungry_app/features/home/view/home_view.dart';
import 'package:hungry_app/features/order_history/view/order_history_view.dart';

class RootView extends StatefulWidget {
  const RootView({super.key});

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  late PageController _controller;
  late List<Widget> screens;
  int currentScreen = 0;

  List<BottomNavigationBarItem> screenIcons = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: "Cart"),
    BottomNavigationBarItem(
      icon: Icon(Icons.local_restaurant_outlined),
      label: "Order History",
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: "Profile",
    ),
  ];

  @override
  void initState() {
    screens = [HomeView(), CartView(), OrderHistoryView(), ProfileView()];
    _controller = PageController(initialPage: currentScreen);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: screens,
        onPageChanged: (v) => setState(() => currentScreen = v),
      ),

      bottomNavigationBar: currentScreen == 3
          ? null
          : Container(
              padding: EdgeInsets.symmetric(vertical: 10),

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.white,
                selectedFontSize: 12,
                unselectedItemColor: Colors.grey.shade400,
                unselectedFontSize: 12,
                showSelectedLabels: true,
                showUnselectedLabels: false,
                currentIndex: currentScreen,
                onTap: (value) {
                  setState(() => currentScreen = value);
                  _controller.jumpToPage(currentScreen);
                },
                items: screenIcons,
              ),
            ),
    );
  }
}
