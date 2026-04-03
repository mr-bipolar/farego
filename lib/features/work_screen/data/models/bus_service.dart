class BusService {
  final String name;
  final double baseFare;
  final double distance;
  final double perKm;
  final int rounded;
  final bool isStepper;

  const BusService({
    required this.name,
    required this.baseFare,
    required this.distance,
    required this.perKm,
    required this.rounded,
    this.isStepper = false,
  });
}
