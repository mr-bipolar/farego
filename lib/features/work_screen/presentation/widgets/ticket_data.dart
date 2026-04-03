import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/features/work_screen/presentation/widgets/ticket_footer.dart';
import 'package:farego/features/work_screen/presentation/widgets/ticket_header.dart';
import 'package:flutter/material.dart';

class TicketData extends StatelessWidget {
  final Vehicle vehicle;
  final List<Widget> children;
  final String totalFare;
  const TicketData({
    super.key,
    required this.vehicle,
    required this.children,
    required this.totalFare,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TicketHeader(icon: vehicle.icon),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            vehicle.label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        TicketFooter(priceLabel: totalFare),
      ],
    );
  }
}
