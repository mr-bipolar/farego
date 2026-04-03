import 'package:farego/features/work_screen/controller/fare_controller.dart';
import 'package:farego/features/work_screen/data/models/fare_model.dart';

class BusFareBuilder {
  static List<FareSlide> build({
    required double baseFare,
    required double baseFareKm,
    required double distanceCharge,
    required double additionalDistanceCharge,
    required double distanceKm,
    required double roundedCharge,
    required int nearestInt,
  }) {
    final slides = <FareSlide>[];
    final adCharge = additionalDistanceCharge.toStringAsFixed(2);
    final roundedBalance = FareController.getRoundBalance(
      roundedCharge,
      nearestInt,
      minimumFare: baseFare,
    );
    final roundedNearest = FareController.roundUpToNearest(
      roundedCharge,
      nearestInt,
      minimumFare: baseFare,
    );

    /// Base Fare
    slides.add(
      FareSlide(
        title: 'Minimum Fare',
        desc: '₹ $baseFare (up to $baseFareKm KM)',
        price: '₹ ${baseFare.toStringAsFixed(2)}',
        tooltip: 'Base fare for first $baseFareKm kilometers',
      ),
    );

    /// Distance Fare
    if (distanceCharge > 0) {
      slides.add(
        FareSlide(
          title: 'Additional Distance',
          desc: '( ${distanceKm.toStringAsFixed(1)} KM  ×  ₹ $adCharge / KM ) ',
          price: '₹ ${distanceCharge.toStringAsFixed(2)}',
          tooltip:
              'Fare for distance beyond minimum distance at ₹ $adCharge / km',
        ),
      );
    }

    /// Rounded Fare
    if (roundedBalance != 0 && roundedCharge != roundedNearest) {
      slides.add(
        FareSlide(
          title: 'Rounding Adjustment',
          desc:
              'Rounded from ₹ ${roundedCharge.toStringAsFixed(2)}  to  ₹ $roundedNearest',
          price: '₹ ${roundedBalance.toStringAsFixed(2)}',
          tooltip:
              'Rounded to nearest ${nearestInt == 1 ? 'rupee' : nearestInt}',
        ),
      );
    }
    return slides;
  }
}
