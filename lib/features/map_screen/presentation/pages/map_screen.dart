import 'dart:async';
import 'package:farego/core/constants/app_strings.dart';
import 'package:farego/features/map_screen/controller/map_controller.dart';
import 'package:farego/features/map_screen/data/models/map_selection.dart';
import 'package:farego/features/map_screen/presentation/widgets/pin_point_text.dart';
import 'package:farego/features/work_screen/presentation/bloc/fare_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ripple_wave/ripple_wave.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Timer? _debounce;

  /// Search
  List<Map<String, dynamic>> _results = [];

  /// Map state
  LatLng? _pickup;
  LatLng? _drop;
  List<LatLng> _routePoints = [];

  /// Names
  String? _pickUpName;
  String? _dropName;

  /// Distance
  double? _totalDistanceKm;

  // [Show Distance In Map]

  LatLng _getPolylineMidPoint(List<LatLng> points) {
    if (points.isEmpty) return const LatLng(0, 0);
    return points[points.length ~/ 2];
  }

  /// Select pickup / drop point [tap or search]
  Future<void> _selectPoint(LatLng point) async {
    // already selected
    if (_pickup != null && _drop != null) {
      _pickup = point;
      _drop = null;
      _dropName = null;
      _routePoints.clear();

      _pickUpName = await MapViewController.getPlaceName(
        point.latitude,
        point.longitude,
      );
      return;
    }

    // Select pickup location
    if (_pickup == null) {
      _pickup = point;
      _pickUpName = await MapViewController.getPlaceName(
        point.latitude,
        point.longitude,
      );
      return;
    }

    // Select drop location
    _drop = point;
    _dropName = await MapViewController.getPlaceName(
      point.latitude,
      point.longitude,
    );
  }

  /// Update route & distance only when both points != null
  Future<void> _updateRouteIfReady() async {
    if (_pickup == null || _drop == null) return;

    final km = await MapViewController.calculateDistance(_pickup!, _drop!);
    final route = await MapViewController.getRoute(_pickup!, _drop!);

    if (!mounted) return;

    setState(() {
      _totalDistanceKm = km;
      _routePoints = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          ///  MAP
          FlutterMap(
            options: MapOptions(
              initialCenter: const LatLng(9.9312, 76.2673), // Kochi
              initialZoom: 13,
              onTap: (_, point) async {
                await _selectPoint(point);
                await _updateRouteIfReady();

                if (!context.mounted) return;
                setState(() {});
              },
            ),
            children: [
              TileLayer(
                urlTemplate: isDark
                    ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
                    : 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: AppStrings.packageName,
              ),

              /// Route
              if (_routePoints.length >= 2)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePoints,
                      strokeWidth: 5,
                      color: Colors.amber.shade300,
                    ),
                  ],
                ),

              /// Markers
              MarkerLayer(
                markers: [
                  if (_pickup != null)
                    Marker(
                      width: 80,
                      height: 80,
                      point: _pickup!,
                      child: RippleWave(
                        color: Colors.green,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.lightGreenAccent,
                          size: 40,
                        ),
                      ),
                    ),

                  if (_drop != null)
                    Marker(
                      width: 80,
                      height: 80,
                      point: _drop!,
                      child: RippleWave(
                        color: Colors.red,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.deepOrangeAccent,
                          size: 40,
                        ),
                      ),
                    ),

                  /// Distance hint text
                  if (_routePoints.isNotEmpty && _totalDistanceKm != null)
                    Marker(
                      point: _getPolylineMidPoint(_routePoints),
                      width: 120,
                      height: 40,
                      child: Card(
                        elevation: 0,
                        color: Colors.black45,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${_totalDistanceKm!.toStringAsFixed(2)} km',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),

          ///  SEARCH
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Material(
                color: Colors.white70,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoSearchTextField(
                      backgroundColor: Colors.white70,
                      padding: const EdgeInsets.all(16),
                      prefixInsets: EdgeInsets.only(left: 14),
                      suffixInsets: EdgeInsets.only(right: 14),
                      onChanged: (value) {
                        _debounce?.cancel();

                        if (value.length < 3) {
                          setState(() => _results.clear());
                          return;
                        }

                        _debounce = Timer(
                          const Duration(milliseconds: 400),
                          () async {
                            final res = await MapViewController.searchPlace(
                              value,
                            );
                            if (!mounted) return;
                            setState(() => _results = res);
                          },
                        );
                      },
                    ),

                    if (_results.isNotEmpty)
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (_, i) {
                            final p = _results[i];
                            return ListTile(
                              title: Text(
                                p['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () async {
                                final point = LatLng(p['lat'], p['lon']);

                                await _selectPoint(point);
                                await _updateRouteIfReady();

                                _results.clear();
                                if (!context.mounted) return;
                                FocusScope.of(context).unfocus();
                                setState(() {});
                              },
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          /// BOTTOM CARD
          if (_pickUpName != null || _dropName != null)
            Positioned(
              bottom: 8,
              left: 8,
              right: 8,
              child: SafeArea(
                top: false,
                child: Card(
                  color: Colors.white70,
                  elevation: 1,
                  shadowColor: Colors.black12,
                  child: Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_pickUpName != null)
                          PinPointText(
                            label: _pickUpName!,
                            iconColor: Colors.green,
                          ),

                        if (_dropName != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: PinPointText(
                              label: _dropName!,
                              iconColor: Colors.red,
                            ),
                          ),

                        if (_pickUpName != null && _dropName != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: Colors.amberAccent.shade100,
                                  foregroundColor: Colors.black87,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  final mapData = MapSelectionResult(
                                    pickup: _pickUpName ?? 'empty',
                                    drop: _dropName ?? 'empty',
                                    distanceKm:
                                        _totalDistanceKm?.roundToDouble() ?? 0,
                                  );
                                  context.read<FareCubit>().setMapData(mapData);
                                  Navigator.pop(context);
                                },
                                child: const Text('Select Distance'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
