class FareBreakdown {
  final double baseFare;
  final double distanceFare;
  final double waitingFare;
  final double nightFare;
  final double kmBaseFare;
  final double additionalDistanceCharge;
  final int roundedInt;
  final double roundedCharge;
  final String total;

  const FareBreakdown({
    required this.baseFare,
    required this.distanceFare,
    required this.waitingFare,
    required this.nightFare,
    required this.total,
    required this.kmBaseFare,
    required this.additionalDistanceCharge,
    required this.roundedInt,
    required this.roundedCharge,
  });

  factory FareBreakdown.empty() {
    return const FareBreakdown(
      baseFare: 0,
      distanceFare: 0,
      waitingFare: 0,
      nightFare: 0,
      kmBaseFare: 0,
      additionalDistanceCharge: 0,
      roundedInt: 0,
      roundedCharge: 0,
      total: '0',
    );
  }
}
