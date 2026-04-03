import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/core/utils/bottomup_navigate.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_cubit.dart';
import 'package:farego/features/work_screen/presentation/pages/work_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final bool isActive;

  const VehicleCard({super.key, required this.vehicle, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      width: 160,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (isActive) {
            context.read<FareCubit>().reset();
            context.read<FareCubit>().changeVehicle(vehicle);
            navigateWithBottomSlide(context, WorkScreen(vehicle: vehicle));
          }
        },
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                vehicle.icon,
                width: 44,
                height: 44,
                colorFilter: ColorFilter.mode(
                  isActive ? colors.primary : const Color(0xFFBDBDBD),
                  BlendMode.srcIn,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Text(
                vehicle.label,
                textAlign: TextAlign.center,
                style: GoogleFonts.sora(
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.black87 : Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
