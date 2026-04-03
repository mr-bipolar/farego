import 'package:farego/features/work_screen/data/models/fare_model.dart';

class TaxiFareBuilder {
  static List<FareSlide> build({
    required double baseFare,
    required double distanceKm,
    required double distanceCharge,
    required double waitingCharge,
    required bool is1500CC,
    required double waitingHour,
  }) {
    final slides = <FareSlide>[];
    // Minimum fare
    slides.add(
      FareSlide(
        title: 'Minimum Fare',
        desc: 'First 5 KM',
        price: '₹ ${baseFare.toStringAsFixed(2)}',
        tooltip:
            'Base fare for first 5 kilometers ( ${is1500CC ? '1500cc and above' : 'below 1500cc'} )',
      ),
    );
    // Distance charge
    if (distanceCharge > 0) {
      slides.add(
        FareSlide(
          title: 'Distance Charge',
          desc:
              '${distanceKm.toStringAsFixed(1)} KM  ×  ₹ ${is1500CC ? 20 : 18} / KM',
          price: '₹ ${distanceCharge.toStringAsFixed(2)}',
          tooltip:
              '₹${is1500CC ? 20 : 18} per kilometer beyond 5 KM for ${is1500CC ? 'high capacity' : 'standard'} taxis',
        ),
      );
    }
    // Waiting charge
    if (waitingCharge > 0) {
      slides.add(
        FareSlide(
          title: 'Waiting Charge',
          desc: '$waitingHour hours  ×  ₹ 50 / hour',
          price: '₹ ${waitingCharge.toStringAsFixed(2)}',
          tooltip: '₹50 per hour, maximum ₹500 per day',
        ),
      );
    }
    return slides;
  }
}
