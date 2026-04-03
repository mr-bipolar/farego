import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemNavBar extends StatelessWidget {
  final Widget child;
  final Color? color;
  final Brightness iconBrightness;

  const SystemNavBar({
    super.key,
    required this.child,
    this.color,
    this.iconBrightness = Brightness.dark,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarIconBrightness: iconBrightness,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: child,
    );
  }
}
