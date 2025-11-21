import 'package:flutter/material.dart';
import 'package:hungry_app/shared/custom_text.dart';

SnackBar customSnack(String message, {Color? color}) {
  return SnackBar(
    backgroundColor: color ?? Colors.red.shade800,
    content: CustomText(text: message, lines: 5),
  );
}
