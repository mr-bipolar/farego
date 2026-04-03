import 'package:farego/core/constants/app_constants.dart';
import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_cubit.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_state.dart';
import 'package:farego/features/work_screen/presentation/widgets/switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AutoRickshawSwitch extends StatelessWidget {
  const AutoRickshawSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(height: 32, thickness: 0.6, color: const Color(0x11000000)),
        AppSpacing.v20,

        // Major City switch
        BlocBuilder<FareCubit, FareState>(
          buildWhen: (prev, curr) => prev.isMajorCity != curr.isMajorCity,
          builder: (context, state) {
            return SwitchButton(
              isCenter: false,
              label: AppStrings.majorCity,
              isActive: state.isMajorCity,
              callBack: (value) {
                context.read<FareCubit>().toggleMajorCity(value);
              },
            );
          },
        ),

        // Night Time switch
        BlocBuilder<FareCubit, FareState>(
          buildWhen: (prev, curr) => prev.isDay != curr.isDay,
          builder: (context, state) {
            return SwitchButton(
              isActive: state.isDay,
              label: AppStrings.nightTime,
              callBack: (value) {
                context.read<FareCubit>().toggleDay(value);
              },
            );
          },
        ),

        // Return Journey switch
        BlocBuilder<FareCubit, FareState>(
          buildWhen: (prev, curr) => prev.isReturn != curr.isReturn,
          builder: (context, state) {
            return SwitchButton(
              isActive: state.isReturn,
              label: AppStrings.returnJourney,
              callBack: (value) {
                context.read<FareCubit>().toggleReturn(value);
              },
            );
          },
        ),
      ],
    );
  }
}
