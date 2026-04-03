import 'package:farego/core/constants/app_constants.dart';
import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/core/widgets/app_title.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // text style for the app bar title
    final appBarTextStyle = GoogleFonts.inter(
      fontWeight: FontWeight.bold,
      color: colors.primary,
      fontSize: AppTextSizes.title,
    );
    return AppBar(
      centerTitle: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppTitleText(text: AppStrings.nameStart, style: appBarTextStyle),
          AppSpacing.h4,
          AppTitleText(
            text: AppStrings.nameEnd,
            style: appBarTextStyle.copyWith(color: colors.secondary),
          ),
        ],
      ),
    );
  }
}
