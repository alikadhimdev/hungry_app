import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/shared/Custom_bottom.dart';
import 'package:hungry_app/shared/custom_text.dart';

class SuccessWidget extends StatelessWidget {
  const SuccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          height: 400,
          width: 300,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary,
                child: Icon(
                  CupertinoIcons.check_mark,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              Gap(20),
              CustomText(
                text: "SUCCESS !",
                color: AppColors.primary,
                size: 40,
                weight: FontWeight.bold,
              ),
              Gap(10),
              CustomText(
                text:
                    "Your payment was successful.\n A receipt for this purchase has \nbeen sent to your email.",
                color: Colors.grey.shade500,
              ),
              Gap(30),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: CustomBottom(text: "Go Back", width: 200, vPadding: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
