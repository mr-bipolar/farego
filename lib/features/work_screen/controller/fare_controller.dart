import 'package:farego/core/enum/vehicle.dart';

class FareController {
  // fix distance double
  static double normalizeDistance({
    required double rawKm,
    required Vehicle vehicle,
    required double busBaseFare,
  }) {
    final fixedVal = (rawKm * 10).round() / 10;
    double lessVal = 0;
    switch (vehicle) {
      case Vehicle.auto:
        lessVal = 1.5;
        break;
      case Vehicle.taxi:
        lessVal = 5.0;
        break;
      case Vehicle.bus:
        lessVal = busBaseFare;
        break;
    }

    final distance = fixedVal - lessVal;
    return distance <= 0 ? 0 : (distance * 10).round() / 10;
  }

  /// Rounded Balance
  static double getRoundBalance(
    double totalValue,
    int nearestInt, {
    double minimumFare = 0,
  }) {
    int rounded = roundUpToNearest(
      totalValue,
      nearestInt,
      minimumFare: minimumFare,
    );
    return rounded - totalValue;
  }

  /// Rounded Nearest Value
  static int roundUpToNearest(
    double totalValue,
    int nearestInt, {
    double minimumFare = 0,
  }) {
    if (totalValue == minimumFare) return totalValue.round();
    if (nearestInt <= 1) return totalValue.round();
    return ((totalValue / nearestInt).ceil()) * nearestInt;
  }
}
