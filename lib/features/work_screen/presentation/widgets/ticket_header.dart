import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class TicketHeader extends StatelessWidget {
  final String icon;
  const TicketHeader({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formattedDate = formatLiveDateTime(now);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(width: 1.0, color: Colors.green),
          ),
          child: Center(
            child: Text(
              formattedDate,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: SvgPicture.asset(
            icon,
            width: 22,
            height: 22,
            colorFilter: ColorFilter.mode(Colors.amber, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }
}

String formatLiveDateTime(DateTime dateTime) {
  return DateFormat('d MMM yyyy, h:mm a').format(dateTime);
}
