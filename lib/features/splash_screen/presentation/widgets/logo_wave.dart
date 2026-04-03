import 'package:animate_do/animate_do.dart';
import 'package:farego/core/constants/app_constants.dart';
import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/core/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ripple_wave/ripple_wave.dart';

class LogoWave extends StatelessWidget {
  const LogoWave({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // text styles for the logo
    final startStyle = GoogleFonts.montserrat(
      color: colors.primary,
      fontSize: AppTextSizes.headline,
      height: 1.5,
      fontWeight: FontWeight.bold,
    );

    final endStyle = GoogleFonts.monaSans(
      color: colors.surface,
      fontSize: AppTextSizes.headline,
      height: 1.5,
      fontWeight: FontWeight.w900,
    );
    return Center(
      child: ZoomIn(
        duration: Duration(seconds: 5),
        child: RippleWave(
          color: colors.onPrimary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTitleText(text: AppStrings.nameStart, style: startStyle),
              AppSpacing.h4,
              AppTitleText(text: AppStrings.nameEnd, style: endStyle),
            ],
          ),
        ),
      ),
    );
  }
}
