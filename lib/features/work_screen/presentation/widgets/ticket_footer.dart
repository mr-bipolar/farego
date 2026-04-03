import 'package:flutter/material.dart';

class TicketFooter extends StatelessWidget {
  final String priceLabel;
  const TicketFooter({super.key, required this.priceLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const TicketView(label: "Total Fare"),
          TicketView(label: priceLabel, isPrice: true),
        ],
      ),
    );
  }
}

/// widget view
class TicketView extends StatelessWidget {
  final String label;
  final bool isPrice;
  const TicketView({super.key, required this.label, this.isPrice = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18.0,
        fontWeight: isPrice ? FontWeight.w700 : FontWeight.bold,
        fontFeatures: isPrice ? const [FontFeature.tabularFigures()] : null,
      ),
    );
  }
}
