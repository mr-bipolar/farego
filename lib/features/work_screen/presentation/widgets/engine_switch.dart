import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_cubit.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_state.dart';
import 'package:farego/features/work_screen/presentation/widgets/switch_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EngineSwitch extends StatelessWidget {
  const EngineSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FareCubit, FareState>(
      buildWhen: (prev, curr) => prev.is1500CC != curr.is1500CC,
      builder: (context, state) {
        return SwitchButton(
          isActive: state.is1500CC,
          label: AppStrings.taxiSwitch,
          callBack: (value) {
            context.read<FareCubit>().toggle1500CC(value);
          },
        );
      },
    );
  }
}
