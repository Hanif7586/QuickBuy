import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomText({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(text,style:
    TextStyle(
      color: color,
      fontSize: 18,
      fontWeight: FontWeight.w700
    ),);
  }
}
