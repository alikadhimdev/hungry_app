import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
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

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(100),
                SvgPicture.asset(
                  "assets/logo/logo.svg",
                  color: AppColors.primary,
                ),
                Gap(10),
                CustomText(
                  text: "Create your Account",
                  color: AppColors.primary,
                ),
                Gap(70),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 50, left: 20, right: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
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
                            color: AppColors.primary,
                            textColor: Colors.white,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                print("sign up success");
                              }
                            },
                          ),
                          Gap(10),
                          CustomAuthButton(
                            text: "Go to Login?",

                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (c) => LoginView()),
                              );
                            },
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
