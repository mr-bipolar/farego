import 'package:farego/core/constants/app_images.dart';

enum Vehicle { auto, bus, taxi }

extension VehicleX on Vehicle {
  String get label {
    switch (this) {
      case Vehicle.auto:
        return 'Auto Rickshaw';
      case Vehicle.bus:
        return 'Bus';
      case Vehicle.taxi:
        return 'Taxi';
    }
  }

  String get icon {
    switch (this) {
      case Vehicle.auto:
        return AppImages.autoIcon;
      case Vehicle.bus:
        return AppImages.busIcon;
      case Vehicle.taxi:
        return AppImages.carIcon;
    }
  }
}
