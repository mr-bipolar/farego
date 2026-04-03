import 'package:flutter/material.dart';

class AppTitleText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const AppTitleText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style);
  }
}
