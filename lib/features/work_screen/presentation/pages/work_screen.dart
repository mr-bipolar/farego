import 'package:farego/core/constants/export_constants.dart';
import 'package:farego/core/enum/vehicle.dart';
import 'package:farego/core/extension/ticketwidget_height.dart';
import 'package:farego/core/utils/blink_navigate.dart';
import 'package:farego/features/map_screen/presentation/pages/map_screen.dart';
import 'package:farego/features/work_screen/exports/workscreen_exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticket_widget/ticket_widget.dart';

class WorkScreen extends StatelessWidget {
  final Vehicle vehicle;
  const WorkScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final vehicleName = vehicle.label;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBarFareView(title: vehicleName),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<FareCubit, FareState>(
            builder: (context, state) {
              List<FareSlide> slides = [];

              /// Vehicles
              final bool isAutoRickshaw = state.vehicle == Vehicle.auto;
              final bool isTaxiService = state.vehicle == Vehicle.taxi;
              final bool isBusService = state.vehicle == Vehicle.bus;

              /// Build Vehicle Widgets
              if (isAutoRickshaw) {
                slides = AutoFareBuilder.build(
                  baseFare: state.breakdown.baseFare,
                  distanceKm: state.distanceKm,
                  distanceCharge: state.breakdown.distanceFare,
                  waitingCharge: state.breakdown.waitingFare,
                  isNight: state.isDay,
                  isMajorCity: state.isMajorCity,
                  isReturn: state.isReturn,
                  nightFare: state.breakdown.nightFare,
                );
              } else if (isTaxiService) {
                slides = TaxiFareBuilder.build(
                  baseFare: state.breakdown.baseFare,
                  distanceKm: state.distanceKm,
                  distanceCharge: state.breakdown.distanceFare,
                  waitingCharge: state.breakdown.waitingFare,
                  waitingHour: state.waitingMinutes,
                  is1500CC: state.is1500CC,
                );
              } else if (isBusService) {
                slides = BusFareBuilder.build(
                  baseFare: state.breakdown.baseFare,
                  baseFareKm: state.breakdown.kmBaseFare,
                  additionalDistanceCharge:
                      state.breakdown.additionalDistanceCharge,
                  distanceCharge: state.breakdown.distanceFare,
                  distanceKm: state.distanceKm,
                  roundedCharge: state.breakdown.roundedCharge,
                  nearestInt: state.breakdown.roundedInt,
                );
              }

              /// vehicles widgets
              List<Widget> buildTicketSlides(List<FareSlide> slides) {
                return slides
                    .map(
                      (slide) => TicketDetails(
                        firstTitle: slide.title,
                        firstDesc: slide.desc,
                        secondDesc: slide.price,
                        toolTip: slide.tooltip,
                      ),
                    )
                    .toList();
              }

              /// widget height
              final height = state.ticketHeight(
                isBus: isBusService,
                isStepper: state.isStepper,
                waitingFare: state.breakdown.waitingFare,
                roundedFare: state.breakdown.roundedCharge,
              );

              /// Slide widgets
              List<Widget> ticketWidgets = buildTicketSlides(slides);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: AnimatedSize(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: 350,
                          minHeight: height,
                          maxHeight: height,
                        ),
                        child: TicketWidget(
                          width: 350,
                          height: height,
                          isCornerRounded: true,
                          padding: const EdgeInsets.all(20),
                          child: TicketData(
                            vehicle: state.vehicle,
                            totalFare: '₹ ${state.breakdown.total}',
                            children: ticketWidgets,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Distance Slider
                  Distance(
                    isBus: isBusService,
                    isTaxi: isTaxiService,
                    showLocation:
                        (state.mapData.pickup != null &&
                        state.mapData.drop != null),
                    location: RouteInfoRow(
                      distance:
                          '${state.mapData.distanceKm.toStringAsFixed(1)} KM',
                      startLocation: state.mapData.pickup ?? '',
                      endLocation: state.mapData.pickup ?? '',
                    ),

                    /// Map button call
                    mapCallback: () =>
                        navigateWithBlink(context, const MapScreen()),

                    /// Distance Button Function
                    distanceCallback: (val) {
                      context.read<FareCubit>().changeDistance(val);
                    },

                    /// Waiting Button Function
                    waitingCallback: (val) =>
                        context.read<FareCubit>().changeWaiting(val),

                    /// Bus Service Type switcher
                    serviceCallback: (value) =>
                        context.read<FareCubit>().changeBusType(value!),
                  ),
                  if (isAutoRickshaw) AutoRickshawSwitch(),
                  if (isTaxiService) EngineSwitch(),
                  AppSpacing.v32,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
