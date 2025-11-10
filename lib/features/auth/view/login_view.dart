import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/widgets/custom_button.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordCOntroller = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      // to hide the keyboard when click out the text field
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Gap(40),
                  SvgPicture.asset("assets/logo/logo.svg"),
                  Gap(20),
                  CustomText(
                    text: "Welcome back, Discover the best fast food",
                    color: Colors.white,
                    size: 13,
                    weight: FontWeight.w500,
                  ),
                  Gap(50),
                  CustomTextField(
                    hint: "Email Address",
                    isPassword: false,
                    controller: emailController,
                  ),
                  Gap(20),
                  CustomTextField(
                    hint: "Password",
                    isPassword: true,
                    controller: passwordCOntroller,
                  ),
                  Gap(40),
                  CustomAuthButton(text: "Sign In"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
