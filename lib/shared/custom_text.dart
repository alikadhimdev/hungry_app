import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.size,
    this.weight,
    this.lines,
  });

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? weight;
  final int? lines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: lines,
      softWrap: true,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
