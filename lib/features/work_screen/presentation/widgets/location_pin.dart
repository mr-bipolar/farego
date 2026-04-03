import 'package:farego/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RouteInfoRow extends StatelessWidget {
  final String distance;
  final String startLocation;
  final String endLocation;

  const RouteInfoRow({
    super.key,
    required this.distance,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = GoogleFonts.manrope(
      fontWeight: FontWeight.w600,
      height: 1.5,
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            distance,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ),
        Column(
          children: [
            AppSpacing.v4,
            Icon(Icons.location_on, size: 22, color: Colors.green),
            Column(
              children: List.generate(
                5,
                (index) => Container(
                  width: 2,
                  height: 5,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            Icon(Icons.location_on, size: 22, color: Colors.red),
          ],
        ),
        AppSpacing.h12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(startLocation, maxLines: 3, style: textStyle),
              AppSpacing.v20,
              Text(endLocation, maxLines: 3, style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}
