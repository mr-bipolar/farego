import 'package:farego/features/work_screen/presentation/widgets/info_button.dart';
import 'package:flutter/material.dart';

class TicketDetails extends StatelessWidget {
  final String firstTitle;
  final String firstDesc;
  final String secondDesc;
  final String toolTip;
  const TicketDetails({
    super.key,
    required this.firstTitle,
    required this.firstDesc,
    required this.secondDesc,
    required this.toolTip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, top: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    firstTitle,
                    style: const TextStyle(color: Color(0xFF8E8E93)),
                  ),
                  const SizedBox(width: 4),
                  AdaptiveInfoButton(message: toolTip),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          // Right side price column
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: SizedBox(
              width: 70,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Price",
                    style: TextStyle(color: Color(0xFF8E8E93)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      secondDesc,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
