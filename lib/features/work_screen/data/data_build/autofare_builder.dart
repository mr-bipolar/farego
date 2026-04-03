import 'package:farego/features/work_screen/data/models/fare_model.dart';

class AutoFareBuilder {
  static List<FareSlide> build({
    required double baseFare,
    required double distanceKm,
    required double distanceCharge,
    required double waitingCharge,
    required bool isNight,
    required bool isMajorCity,
    required bool isReturn,
    required double nightFare,
  }) {
    final slides = <FareSlide>[];
    // Minimum fare
    slides.add(
      FareSlide(
        title: 'Minimum Fare',
        desc: '1.5 KM',
        price: '₹ ${baseFare.toStringAsFixed(2)}',
        tooltip: 'Base fare charged for the first 1.5 kilometers of travel',
      ),
    );

    // Distance charge
    if (distanceCharge > 0) {
      slides.add(
        FareSlide(
          title: 'Distance Charge',
          desc:
              '( ${distanceKm.toStringAsFixed(1)} KM  ×  ₹15 / KM ) '
              '${(!isNight && !isMajorCity && !isReturn) ? ' ×  1.5' : ''}',
          price: '₹ ${distanceCharge.toStringAsFixed(2)}',
          tooltip: '₹15 per kilometer beyond the first 1.5 KM',
        ),
      );
    }

    // Waiting charge
    if (waitingCharge > 0) {
      slides.add(
        FareSlide(
          title: 'Waiting Charge',
          desc: '₹10 per 15 minutes',
          price: '₹ ${waitingCharge.toStringAsFixed(2)}',
          tooltip: '₹10 charged for every 15 minutes of waiting time',
        ),
      );
    }

    // Night charge
    if (isNight && nightFare > 0) {
      slides.add(
        FareSlide(
          title: 'Night Time Charge',
          desc: nightFareText(distanceCharge, waitingCharge),
          price: '₹ ${nightFare.toStringAsFixed(2)}',
          tooltip: '50% additional charge for travel between 10 PM and 5 AM',
        ),
      );
    }

    return slides;
  }
}

/// Night fare
String nightFareText(double distanceCharge, double waitingCharge) {
  List<String> parts = ['₹30'];
  if (distanceCharge > 0) {
    parts.add('₹${distanceCharge.toStringAsFixed(0)}');
  }
  if (waitingCharge > 0) {
    parts.add('₹${waitingCharge.toStringAsFixed(0)}');
  }
  return '( ${parts.join('  +  ')} )  ×  0.5';
}
