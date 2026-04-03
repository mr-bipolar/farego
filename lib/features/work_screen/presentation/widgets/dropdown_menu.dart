import 'package:farego/features/work_screen/data/datasources/vehicle_dataset.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BusDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;
  final String hint;
  final String label;

  const BusDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.hint,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final busServiceItems = VehicleDataset.busServiceMap.entries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(entry.value.name),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 22),

        DropdownButtonFormField<String>(
          initialValue: value,
          items: busServiceItems,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFFDFDFD),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
      ],
    );
  }
}
