import 'package:farego/core/constants/export_constants.dart';
import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/features/map_screen/data/models/map_selection.dart';
import 'package:farego/features/work_screen/controller/fare_controller.dart';
import 'package:farego/features/work_screen/data/models/fare_breakdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'fare_state.dart';

class FareCubit extends Cubit<FareState> {
  FareCubit() : super(FareState.initial());

  // Vehicle change
  void changeVehicle(Vehicle vehicle) {
    emit(state.copyWith(vehicle: vehicle));
    _recalculate();
  }

  // Distance change
  void changeDistance(double km) {
    final distance = _additionalDistance(km);
    emit(state.copyWith(distanceKm: distance));
    _recalculate();
  }

  // Auto Rickshaw Return Toggle
  void toggleReturn(bool value) {
    emit(state.copyWith(isReturn: value));
    _recalculate();
  }

  // Auto Rickshaw Major City Toggle
  void toggleMajorCity(bool value) {
    emit(state.copyWith(isMajorCity: value));
    _recalculate();
  }

  // Auto Rickshaw Night Time Toggle
  void toggleDay(bool value) {
    emit(state.copyWith(isDay: value));
    _recalculate();
  }

  // Taxi 1500CC Toggle
  void toggle1500CC(bool value) {
    emit(state.copyWith(is1500CC: value));
    _recalculate();
  }

  // Auto Rickshaw and Taxi  Waiting time change
  void changeWaiting(double minutes) {
    emit(state.copyWith(waitingMinutes: minutes));
    _recalculate();
  }

  // Change bus type
  void changeBusType(String busType) {
    emit(state.copyWith(selectedBusType: busType, distanceKm: 0));
    _recalculate();
  }

  // Set map data
  void setMapData(MapSelectionResult mapData) {
    emit(state.copyWith(mapData: mapData));
    changeDistance(mapData.distanceKm);
  }

  // State Reset
  void reset() {
    emit(FareState.initial());
  }

  ///  additional Distance
  double _additionalDistance(double km) {
    return FareController.normalizeDistance(
      rawKm: km,
      vehicle: state.vehicle,
      busBaseFare: state.breakdown.kmBaseFare,
    );
  }

  /// Calculate Distance
  double _calculateDistanceCharge({
    double ratePerKm = 0,
    double distanceCharge = 0,
  }) {
    final distanceKm = state.distanceKm;
    if (distanceKm <= 0) return 0.0;
    switch (state.vehicle) {
      case Vehicle.bus:
        return distanceKm * distanceCharge;

      case Vehicle.taxi:
        return distanceKm * ratePerKm;

      case Vehicle.auto:
        final double baseFare = distanceKm * ratePerKm;
        final bool isNormalFare =
            state.isDay || state.isMajorCity || state.isReturn;

        return baseFare * (isNormalFare ? 1.0 : 1.5);
    }
  }

  /// Calculate Waiting time charge
  double _calculateWaitingFare(double waitingMinutes, double waitingRate) {
    if (waitingMinutes <= 0) return 0.0;

    switch (state.vehicle) {
      case Vehicle.bus:
        return 0;

      case Vehicle.taxi:
        int halfBlocks = (waitingMinutes * 2).round();
        int chargedHours = (halfBlocks + 1) ~/ 2;
        return chargedHours * waitingRate;

      case Vehicle.auto:
        int wholeMinutes = waitingMinutes.floor();
        return ((wholeMinutes + 14) ~/ 15) * waitingRate;
    }
  }

  /// Calculate  Night Fare
  double _calculateNightFare({
    required double distanceCharge,
    required double waitingCharge,
  }) {
    const double baseFare = 30.0;
    const double nightMultiplier = 0.5;
    if (state.isDay) {
      return (baseFare + distanceCharge + waitingCharge) * nightMultiplier;
    }
    return 0;
  }

  /// Core fare logic
  void _recalculate() {
    dynamic vehicleData;
    double distanceFare = 0;
    double baseFare = 0;
    double perKm = 0;
    double waitingFare = 0;
    double nightFare = 0;
    String totalFare;

    /// Vehicle data set
    switch (state.vehicle) {
      case Vehicle.bus:
        vehicleData = VehicleDataset.busServiceMap[state.selectedBusType];
        break;

      case Vehicle.taxi:
        vehicleData = VehicleDataset.taxiService();
        break;

      case Vehicle.auto:
        vehicleData = VehicleDataset.autoService();
        break;
    }

    /// [  If Vehicle is car  and 1500CC
    ///    set base fare and per km
    ///    else default from dataset ]

    if (state.is1500CC) {
      baseFare = 225;
      perKm = 20;
    } else {
      baseFare = vehicleData.baseFare;
      perKm = vehicleData.perKm;
    }

    final bool isAutoRickshaw = state.vehicle == Vehicle.auto;
    final bool isTaxi = state.vehicle == Vehicle.taxi;
    final bool isBus = state.vehicle == Vehicle.bus;

    /// [ If vehicle is car or auto  set
    ///   distance , waiting and night Fare ]

    if (isAutoRickshaw || isTaxi) {
      /// distance fare
      distanceFare = _calculateDistanceCharge(ratePerKm: perKm);

      /// waiting fare
      waitingFare = _calculateWaitingFare(
        state.waitingMinutes,
        vehicleData.waitingRate,
      );

      /// auto night fare
      if (isAutoRickshaw) {
        nightFare = _calculateNightFare(
          distanceCharge: distanceFare,
          waitingCharge: waitingFare,
        );
      }
    }

    /// Bus  distance fare
    if (isBus) {
      final stepper = vehicleData.isStepper ?? false;
      final startKm = stepper ? 0.1 : 0.5;
      if (state.distanceKm >= startKm) {
        distanceFare = _calculateDistanceCharge(
          distanceCharge: vehicleData.perKm,
        );
      }
    }

    /// Rounded Fare for Bus
    final double roundedFare =
        (baseFare + distanceFare + waitingFare + nightFare);

    /// Total fare
    if (isBus) {
      final double totalValue = baseFare + distanceFare;
      totalFare = FareController.roundUpToNearest(
        totalValue,
        state.breakdown.roundedInt,
        minimumFare: state.breakdown.baseFare,
      ).toStringAsFixed(2);
    } else {
      totalFare = roundedFare.toStringAsFixed(2);
    }

    emit(
      state.copyWith(
        mapData: state.mapData,
        isStepper: isBus ? vehicleData.isStepper : false,
        breakdown: FareBreakdown(
          baseFare: baseFare,
          distanceFare: distanceFare,
          waitingFare: waitingFare,
          nightFare: nightFare,
          kmBaseFare: isBus ? vehicleData.distance : 0,
          additionalDistanceCharge: perKm,
          roundedInt: isBus ? vehicleData.rounded : 0,
          roundedCharge: roundedFare,
          total: totalFare,
        ),
      ),
    );
  }
}
