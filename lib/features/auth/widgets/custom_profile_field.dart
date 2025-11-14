import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomProfileField extends StatefulWidget {
  const CustomProfileField({
    super.key,
    required this.text,
    required this.hint,
    required this.isPassword,
  });
  final String text, hint;
  final bool isPassword;

  @override
  State<CustomProfileField> createState() => _CustomProfileFieldState();
}

class _CustomProfileFieldState extends State<CustomProfileField> {
  late bool _obscure;
  @override
  void initState() {
    _obscure = widget.isPassword;
    super.initState();
  }

  void _togglePassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      cursorHeight: 20,
      initialValue: widget.text,
      obscureText: _obscure,

      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: widget.hint,
        labelStyle: TextStyle(color: Colors.grey.shade400),
        suffixIcon: GestureDetector(
          onTap: _togglePassword,
          child: widget.isPassword
              ? Icon(CupertinoIcons.eye, color: Colors.white)
              : SizedBox(),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
      ),
    );
  }
}
