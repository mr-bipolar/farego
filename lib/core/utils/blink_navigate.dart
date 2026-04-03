import 'package:flutter/material.dart';

void navigateWithBlink(
  BuildContext context,
  Widget page, {
  bool isPush = true,
}) {
  final route = PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );

  if (isPush) {
    Navigator.of(context).push(route);
  } else {
    Navigator.of(context).pushReplacement(route);
  }
}
