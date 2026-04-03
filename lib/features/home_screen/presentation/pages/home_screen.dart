import 'package:farego/core/constants/app_constants.dart';
import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/core/utils/navbar.dart';
import 'package:farego/features/home_screen/presentation/widgets/app_bar.dart';
import 'package:farego/features/home_screen/presentation/widgets/screen_labels.dart';
import 'package:farego/features/home_screen/presentation/widgets/vehicle_swiper.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SystemNavBar(
      child: Scaffold(
        appBar: AppBarWidget(),
        body: Padding(
          padding: AppPadding.medium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.12),
              ScreenLabels(label: AppStrings.headerTitle, isTitle: true),
              AppSpacing.v12,
              ScreenLabels(label: AppStrings.subTitle),
              AppSpacing.v32,
              ReactiveCurvedCards(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
