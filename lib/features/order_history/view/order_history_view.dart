import 'package:flutter/material.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/shared/Custom_bottom.dart';
import 'package:hungry_app/shared/custom_go_login.dart';
import 'package:hungry_app/shared/custom_text.dart';

import '../../cart/data/items_data.dart';

class OrderHistoryView extends StatefulWidget {
  const OrderHistoryView({super.key});

  @override
  State<OrderHistoryView> createState() => _OrderHistoryViewState();
}

class _OrderHistoryViewState extends State<OrderHistoryView> {
  AuthRepo authRepo = AuthRepo();
  bool isGest = false;
  UserModel? userModel;

  Future<void> _checkLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGest = authRepo.isGest);
    if (user != null) setState(() => userModel = user);
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    if (isGest) {
      return customGoLogin(context);
    } else {
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
              return Card(
                color: Colors.white,
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset("assets/test/test.png", width: 110),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: items[index].title,
                                weight: FontWeight.bold,
                              ),
                              CustomText(text: "QTY: X3"),
                              CustomText(text: "Price: \$ 20.99"),
                            ],
                          ),
                        ],
                      ),

                      CustomBottom(
                        text: "Re-Order",
                        width: double.infinity,
                        color: Colors.grey.shade400,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
