import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_profile_field.dart';
import 'package:hungry_app/shared/custom_text.dart';
import "../../../root.dart";

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _address = TextEditingController();

  @override
  void initState() {
    _name.text = "Ali Kadhim";
    _email.text = "alikadhim@gmail.com";
    _address.text = "Baghdad, Iraq";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        appBar: AppBar(
          backgroundColor: AppColors.primary,
          leading: GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (c) => RootView()),
            ),
            child: Icon(CupertinoIcons.back, color: Colors.white),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(Icons.settings, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: BoxBorder.all(color: Colors.white, width: 3),
                    ),
                    child: Image.asset("assets/test/test.png"),
                  ),

                  Gap(30),
                  CustomProfileField(hint: "Name", controller: _name),
                  Gap(15),
                  CustomProfileField(hint: "Email", controller: _email),
                  Gap(15),
                  CustomProfileField(
                    hint: "Delivery Address",
                    controller: _address,
                  ),
                  Gap(30),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Image.asset(
                        "assets/checkout/visa.png",
                        width: 80,
                      ),
                      title: CustomText(
                        text: "Debit card",
                        weight: FontWeight.w700,
                      ),
                      subtitle: CustomText(
                        text: "3566 **** **** 0505",
                        size: 12,
                      ),
                      trailing: CustomText(text: "DEFAULT"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        bottomSheet: Container(
          height: 100,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    CustomText(
                      text: "Update",
                      color: Colors.white,
                      weight: FontWeight.bold,
                      size: 16,
                    ),
                    Gap(30),
                    Icon(CupertinoIcons.pencil, color: Colors.white),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (c) => LoginView()),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 2),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CustomText(
                        text: "Exit",
                        color: AppColors.primary,
                        weight: FontWeight.bold,
                        size: 16,
                      ),
                      Gap(30),
                      Icon(Icons.exit_to_app_rounded, color: AppColors.primary),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
