import 'package:farego/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PinPointText extends StatelessWidget {
  final Color iconColor;
  final String label;
  const PinPointText({super.key, required this.iconColor, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.location_on, color: iconColor),
        AppSpacing.h8,
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
