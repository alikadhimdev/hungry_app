import 'package:flutter/material.dart';

class CustomProfileField extends StatefulWidget {
  const CustomProfileField({
    super.key,
    this.hint,
    required this.controller,
    this.type,
  });
  final String? hint;
  final TextEditingController controller;
  final TextInputType? type;

  @override
  State<CustomProfileField> createState() => _CustomProfileFieldState();
}

class _CustomProfileFieldState extends State<CustomProfileField> {
  late TextEditingController _controller;
  @override
  void initState() {
    _controller = widget.controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      cursorHeight: 20,
      controller: _controller,
      style: TextStyle(color: Colors.white),
      keyboardType: widget.type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),

        labelText: widget.hint,
        labelStyle: TextStyle(color: Colors.grey.shade400),

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
