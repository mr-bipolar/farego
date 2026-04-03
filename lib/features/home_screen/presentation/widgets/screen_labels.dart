import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenLabels extends StatelessWidget {
  final String label;
  final bool isTitle;
  const ScreenLabels({super.key, required this.label, this.isTitle = false});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: isTitle
            ? GoogleFonts.lexend(fontSize: 22, fontWeight: FontWeight.w600)
            : GoogleFonts.interTight(fontWeight: FontWeight.w500),
      ),
    );
  }
}
