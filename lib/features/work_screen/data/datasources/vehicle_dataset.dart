import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/features/work_screen/data/models/auto_service.dart';
import 'package:farego/features/work_screen/data/models/bus_service.dart';
import 'package:farego/features/work_screen/data/models/taxi_service.dart';

class VehicleDataset {
  /// Auto service
  static AutoService autoService() => AutoService(
    name: Vehicle.auto.label,
    baseFare: 30,
    perKm: 15,
    waitingRate: 10,
  );

  /// Taxi Service
  static TaxiService taxiService() => TaxiService(
    name: Vehicle.taxi.label,
    baseFare: 200,
    perKm: 18,
    waitingRate: 50,
  );

  /// Bus service
  static const Map<String, BusService> busServiceMap = {
    'Ordinary': BusService(
      name: 'Ordinary / Mofussil Services',
      baseFare: 10,
      distance: 2.5,
      perKm: 1.00,
      rounded: 1,
    ),
    'CityFast': BusService(
      name: 'City Fast Services',
      baseFare: 12,
      distance: 2.5,
      perKm: 1.03,
      rounded: 1,
    ),
    'FastPassenger': BusService(
      name: 'Fast Passenger Services',
      baseFare: 15,
      distance: 5,
      perKm: 1.05,
      rounded: 1,
    ),
    'SuperFast': BusService(
      name: 'Super Fast Services',
      baseFare: 22,
      distance: 10,
      perKm: 1.08,
      rounded: 1,
    ),
    'Express': BusService(
      name: 'Express / Super Express Services',
      baseFare: 28,
      distance: 15,
      perKm: 1.10,
      rounded: 5,
      isStepper: true,
    ),
    'SuperAirExpress': BusService(
      name: 'Super Air Express',
      baseFare: 35,
      distance: 15,
      perKm: 1.15,
      rounded: 5,
      isStepper: true,
    ),
    'SuperDeluxe': BusService(
      name: 'Super Deluxe / Semi Sleeper Services',
      baseFare: 40,
      distance: 15,
      perKm: 1.20,
      rounded: 10,
      isStepper: true,
    ),
    'LuxuryAC': BusService(
      name: 'Luxury / High-Tech & AC Services',
      baseFare: 60,
      distance: 20,
      perKm: 1.50,
      rounded: 10,
      isStepper: true,
    ),
    'SingleAxle': BusService(
      name: 'Single Axle Services',
      baseFare: 60,
      distance: 20,
      perKm: 1.81,
      rounded: 10,
      isStepper: true,
    ),
    'MultiAxle': BusService(
      name: 'Multi Axle Services',
      baseFare: 100,
      distance: 20,
      perKm: 2.25,
      rounded: 10,
      isStepper: true,
    ),
    'LowFloorAC': BusService(
      name: 'Low Floor AC Services',
      baseFare: 26,
      distance: 5,
      perKm: 1.75,
      rounded: 2,
      isStepper: true,
    ),
    'LowFloorNonAC': BusService(
      name: 'Low Floor Non-AC Services',
      baseFare: 10,
      distance: 2.5,
      perKm: 1.00,
      rounded: 1,
    ),
    'ACSleeper': BusService(
      name: 'A/C Sleeper Services',
      baseFare: 130,
      distance: 20,
      perKm: 2.50,
      rounded: 10,
      isStepper: true,
    ),
  };
}
