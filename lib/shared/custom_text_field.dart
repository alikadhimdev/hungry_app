import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hungry_app/core/constants/app_colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.hint,
    required this.isPassword,
    required this.controller,
    this.textColor,
    this.borderCOlor,
  });
  final String hint;
  final bool isPassword;
  final TextEditingController controller;
  final Color? textColor;
  final Color? borderCOlor;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    _obscureText = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "please enter ${widget.hint}";
        }
        return null;
      },
      controller: widget.controller,
      obscureText: _obscureText,
      cursorColor: AppColors.primary,
      cursorHeight: 20,

      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hint: Text(widget.hint),
        fillColor: widget.borderCOlor ?? Colors.white,
        filled: true,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: _togglePassword,
                child: Icon(CupertinoIcons.eye),
              )
            : SizedBox(),
      ),
    );
  }
}
