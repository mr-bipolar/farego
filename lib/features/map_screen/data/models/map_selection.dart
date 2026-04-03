class MapSelectionResult {
  final String? pickup;
  final String? drop;
  final double distanceKm;

  MapSelectionResult({
    required this.pickup,
    required this.drop,
    required this.distanceKm,
  });

  factory MapSelectionResult.empty() {
    return MapSelectionResult(pickup: null, drop: null, distanceKm: 0);
  }
}
