import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/features/map_screen/data/models/map_selection.dart';
import 'package:farego/features/work_screen/data/models/fare_breakdown.dart';

class FareState {
  final Vehicle vehicle;
  final double distanceKm;
  final double waitingMinutes;
  final String selectedBusType;
  final MapSelectionResult mapData;

  final bool isDay;
  final bool is1500CC;
  final bool isReturn;
  final bool isMajorCity;
  final bool isStepper;
  final double distanceCharge;

  final FareBreakdown breakdown;

  const FareState({
    required this.vehicle,
    required this.distanceKm,
    required this.waitingMinutes,
    required this.selectedBusType,
    required this.isDay,
    required this.is1500CC,
    required this.isMajorCity,
    required this.isReturn,
    required this.isStepper,
    required this.distanceCharge,
    required this.breakdown,
    required this.mapData,
  });

  factory FareState.initial() {
    return FareState(
      vehicle: Vehicle.auto,
      distanceKm: 0.0,
      waitingMinutes: 0,
      distanceCharge: 0,
      isDay: false,
      isMajorCity: false,
      isReturn: false,
      is1500CC: false,
      isStepper: false,
      selectedBusType: 'Ordinary',
      breakdown: FareBreakdown.empty(),
      mapData: MapSelectionResult.empty(),
    );
  }

  FareState copyWith({
    Vehicle? vehicle,
    double? distanceKm,
    double? waitingMinutes,
    String? selectedBusType,
    bool? isDay,
    bool? is1500CC,
    bool? isReturn,
    bool? isMajorCity,
    bool? isStepper,
    double? distanceCharge,
    MapSelectionResult? mapData,
    FareBreakdown? breakdown,
  }) {
    return FareState(
      vehicle: vehicle ?? this.vehicle,
      distanceKm: distanceKm ?? this.distanceKm,
      waitingMinutes: waitingMinutes ?? this.waitingMinutes,
      selectedBusType: selectedBusType ?? this.selectedBusType,
      mapData: mapData ?? this.mapData,
      isDay: isDay ?? this.isDay,
      is1500CC: is1500CC ?? this.is1500CC,
      isReturn: isReturn ?? this.isReturn,
      isStepper: isStepper ?? this.isStepper,
      isMajorCity: isMajorCity ?? this.isMajorCity,
      distanceCharge: distanceCharge ?? this.distanceCharge,
      breakdown: breakdown ?? this.breakdown,
    );
  }
}
