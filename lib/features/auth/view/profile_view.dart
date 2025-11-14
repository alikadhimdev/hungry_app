import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/widgets/custom_profile_field.dart';
import "../../../root.dart";

// ignore: must_be_immutable
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

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
          actions: [Icon(Icons.settings, color: Colors.white)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: BoxBorder.all(color: Colors.white, width: 3),
                    ),
                    child: Image.asset("assets/test/test.png"),
                  ),

                  Gap(30),
                  CustomProfileField(
                    text: "Ali Kadhim",
                    hint: "Name",
                    isPassword: false,
                  ),
                  Gap(20),
                  CustomProfileField(
                    text: "ali@email.com",
                    hint: "Email",
                    isPassword: false,
                  ),
                  Gap(20),
                  CustomProfileField(
                    text: "Iraq - Basra",
                    hint: "Delivery Address",
                    isPassword: false,
                  ),
                  Gap(20),
                  CustomProfileField(
                    text: "12345678",
                    hint: "Password",
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
