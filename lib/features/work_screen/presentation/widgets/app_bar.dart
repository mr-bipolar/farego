import 'package:farego/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarFareView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  const AppBarFareView({super.key, this.title});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "$title Fare Calculator",
        style: GoogleFonts.interTight(
          fontSize: AppTextSizes.medium,
          fontWeight: FontWeight.w500,
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.maybeOf(context)?.pop(),
        icon: const Icon(Icons.close),
      ),
    );
  }
}
