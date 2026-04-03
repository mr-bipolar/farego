import 'package:farego/core/constants/app_constants.dart';
import 'package:farego/features/work_screen/presentation/widgets/dropdown_menu.dart';
import 'package:farego/features/work_screen/presentation/widgets/input_double.dart';
import 'package:flutter/material.dart' hide DropdownMenu;
import 'package:google_fonts/google_fonts.dart';

class Distance extends StatelessWidget {
  final Widget location;
  final bool showLocation;
  final bool isBus;
  final bool isTaxi;
  final void Function(double) distanceCallback;
  final void Function(double) waitingCallback;
  final void Function(String?) serviceCallback;
  final void Function() mapCallback;

  const Distance({
    super.key,
    required this.location,
    this.showLocation = false,
    this.isBus = false,
    this.isTaxi = false,
    required this.distanceCallback,
    required this.waitingCallback,
    required this.serviceCallback,
    required this.mapCallback,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Distance (KM)",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: showLocation ? 32 : 0),
            child: Visibility(visible: showLocation, child: location),
          ),
          Row(
            children: [
              UniversalStepper(
                min: 0,
                max: 100,
                step: 0.1,
                decimals: 1,
                initialValue: isBus
                    ? 2.5
                    : isTaxi
                    ? 5
                    : 1.5,
                onChanged: distanceCallback,
              ),
              SizedBox(width: 12),
              Text(
                'OR',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextButton.icon(
                  icon: Icon(Icons.map_outlined),
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.amber.shade50,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: colors.primary),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: mapCallback,
                  label: Text("Use Map"),
                ),
              ),
            ],
          ),
          AppSpacing.v12,
          Visibility(
            visible: !isBus,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                UniversalStepper(
                  min: 0,
                  max: 180,
                  step: isTaxi ? 0.5 : 1,
                  decimals: isTaxi ? 1 : 0,
                  initialValue: 0,
                  width: 80,
                  onChanged: waitingCallback,
                ),
                Flexible(
                  child: Text(
                    "Waiting Time (${isTaxi ? 'hours' : 'minutes'})",
                    style: GoogleFonts.aBeeZee(fontWeight: .w500, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: isBus,
            child: Padding(
              padding: const EdgeInsets.only(top: 12, left: 8.0),
              child: BusDropdown(
                label: 'Bus Service Type',
                value: 'Ordinary',
                hint: 'Select service',
                onChanged: serviceCallback,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
