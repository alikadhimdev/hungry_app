import 'package:flutter/material.dart';
import 'package:hungry_app/shared/custom_text.dart';

SnackBar customSnack(String message) {
  return SnackBar(
    backgroundColor: Colors.red.shade800,
    content: CustomText(text: message),
  );
}
