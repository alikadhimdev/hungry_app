import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../features/auth/view/login_view.dart';
import 'Custom_bottom.dart';
import 'custom_text.dart';

Widget customGoLogin(context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(text: "You are a Gest, please login first", size: 20),
        Gap(20),
        CustomBottom(
          text: "Login ",
          height: 40,
          width: 200,
          onTap: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (c) => LoginView()),
          ),
        ),
      ],
    ),
  );
}
