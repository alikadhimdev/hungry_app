import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/widgets/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_text_field.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(40),
                SvgPicture.asset("assets/logo/logo.svg"),
                Gap(10),
                CustomText(text: "Create your Account", color: Colors.white),
                Gap(30),
                CustomTextField(
                  hint: "Username",
                  isPassword: false,
                  controller: usernameController,
                ),
                Gap(10),
                CustomTextField(
                  hint: "Email",
                  isPassword: false,
                  controller: emailController,
                ),
                Gap(10),
                CustomTextField(
                  hint: "Password",
                  isPassword: true,
                  controller: passwordController,
                ),
                Gap(10),
                CustomTextField(
                  hint: "Confirm Password",
                  isPassword: true,
                  controller: confirmPasswordController,
                ),
                Gap(30),
                CustomAuthButton(
                  text: "Sign Up",
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      print("sign up success");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
