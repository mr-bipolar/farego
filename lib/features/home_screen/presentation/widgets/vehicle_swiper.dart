import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/features/home_screen/presentation/widgets/vehicle_card.dart';
import 'package:flutter/material.dart';

class ReactiveCurvedCards extends StatefulWidget {
  const ReactiveCurvedCards({super.key});

  @override
  State<ReactiveCurvedCards> createState() => _ReactiveCurvedCardsState();
}

class _ReactiveCurvedCardsState extends State<ReactiveCurvedCards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int _centerIndex = 1;
  final _vehicles = Vehicle.values;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  /// swipe left
  void _swipeLeft() async {
    await _controller.forward();
    setState(() {
      _centerIndex = (_centerIndex + 1) % _vehicles.length;
    });
    _controller.reset();
  }

  /// swipe right
  void _swipeRight() async {
    await _controller.forward();
    setState(() {
      _centerIndex = (_centerIndex - 1 + _vehicles.length) % _vehicles.length;
    });
    _controller.reset();
  }

  /// Card transform
  Widget _card({
    required double baseX,
    required double t,
    bool isCenter = false,
    required Vehicle vehicle,
  }) {
    final double tt = t.clamp(0.0, 1.0);
    const double sideYOffset = 28.0;
    const double maxRotation = 0.35;
    const double minScale = 0.9;

    final double x = baseX * (1 - tt);
    final double y = isCenter ? 0 : sideYOffset * (1 - tt);
    final double rotation = isCenter
        ? 0
        : (baseX.sign * maxRotation) * (1 - tt);
    final double scale = isCenter ? 1.0 : minScale + (0.1 * tt);

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..translateByDouble(x, y, 0, 1)
        ..rotateZ(rotation)
        ..scaleByDouble(scale, scale, 1, 1),
      child: RepaintBoundary(
        child: VehicleCard(vehicle: vehicle, isActive: isCenter),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.velocity.pixelsPerSecond.dx < 0) {
          _swipeLeft();
        } else if (details.velocity.pixelsPerSecond.dx > 0) {
          _swipeRight();
        }
      },
      child: SizedBox(
        height: 260,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            final t = _controller.value;

            int leftIndex =
                (_centerIndex - 1 + _vehicles.length) % _vehicles.length;
            int rightIndex = (_centerIndex + 1) % _vehicles.length;

            return Stack(
              alignment: Alignment.center,
              children: [
                _card(baseX: -110, t: t, vehicle: _vehicles[leftIndex]),
                _card(baseX: 110, t: t, vehicle: _vehicles[rightIndex]),
                _card(
                  baseX: 0,
                  t: 0,
                  isCenter: true,
                  vehicle: _vehicles[_centerIndex],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
