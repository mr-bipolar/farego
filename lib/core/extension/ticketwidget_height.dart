import 'package:farego/features/work_screen/presentation/bloc/fare_state.dart';

extension TicketLayout on FareState {
  double ticketHeight({
    required bool isBus,
    required bool isStepper,
    required double waitingFare,
    required double roundedFare,
  }) {
    double baseHeight = 260;
    const double rowHeight = 80;
    const double maxHeight = 470;

    int rows = 0;

    final double minVisibleDistance = isBus ? (isStepper ? 0.1 : 0.5) : 0;

    if (distanceKm >= minVisibleDistance) rows++;
    if (waitingFare > 0) rows++;
    if (isDay) rows++;
    if (isBus && roundedFare != 0) rows++;

    final double height = baseHeight + (rows * rowHeight);

    return height.clamp(baseHeight, maxHeight);
  }
}
