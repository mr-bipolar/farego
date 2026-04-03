import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final bool isCenter;
  final void Function(bool)? callBack;
  const SwitchButton({
    super.key,
    required this.callBack,
    required this.label,
    this.isActive = false,
    this.isCenter = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        crossAxisAlignment: isCenter
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Transform.scale(
            scale: 0.7,
            child: CupertinoSwitch(value: isActive, onChanged: callBack),
          ),
          Flexible(
            child: Text(
              label,
              style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
                height: 1.5,
                fontSize: 15.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
