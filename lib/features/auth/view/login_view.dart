import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/signup_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_button.dart';
import 'package:hungry_app/root.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:hungry_app/shared/custom_text_field.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return GestureDetector(
      // to hide the keyboard when click out the text field
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Gap(150),
                SvgPicture.asset(
                  "assets/logo/logo.svg",
                  color: AppColors.primary,
                ),
                Gap(20),
                CustomText(
                  text: "Welcome back, Discover the best fast food",
                  color: AppColors.primary,
                  size: 13,
                  weight: FontWeight.w500,
                ),
                Gap(50),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          CustomTextField(
                            hint: "Email Address",
                            isPassword: false,
                            controller: emailController,
                          ),
                          Gap(20),
                          CustomTextField(
                            hint: "Password",
                            isPassword: true,
                            controller: passwordController,
                          ),
                          Gap(40),
                          CustomAuthButton(
                            text: "Sign In",
                            color: AppColors.primary,
                            textColor: Colors.white,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print("sign in success");
                              }
                            },
                          ),
                          Gap(10),
                          CustomAuthButton(
                            text: "Create An Account!",
                            color: Colors.white,
                            textColor: AppColors.primary,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (c) => SignupView()),
                              );
                            },
                          ),
                          Gap(20),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (c) => RootView()),
                            ),
                            child: CustomText(
                              text: "Continue as a Gest",
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          Gap(200),
                        ],
                      ),
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
