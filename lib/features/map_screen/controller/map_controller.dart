import 'dart:convert';
import 'package:farego/core/config/config.dart';
import 'package:farego/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class MapViewController {
  static const packageName = AppStrings.packageName;
  static const mapServer = AppConfig.mapServer;
  static const routeServer = AppConfig.routeServer;

  /// Search function
  static Future<List<Map<String, dynamic>>> searchPlace(String query) async {
    try {
      final uri = Uri.parse('$mapServer/search?q=$query&format=json&limit=5');

      final response = await http.get(
        uri,
        headers: {'User-Agent': packageName},
      );

      if (response.statusCode != 200) {
        return [];
      }

      final List<dynamic> data = json.decode(response.body);

      return data
          .map<Map<String, dynamic>>((e) {
            return {
              'name': e['display_name'] ?? '',
              'lat': double.tryParse(e['lat']?.toString() ?? ''),
              'lon': double.tryParse(e['lon']?.toString() ?? ''),
            };
          })
          .where((e) => e['lat'] != null && e['lon'] != null)
          .toList();
    } catch (e) {
      debugPrint('searchPlace error: $e');
      return [];
    }
  }

  /// Distance Calculator
  static Future<double> calculateDistance(LatLng start, LatLng end) async {
    try {
      final uri = Uri.parse(
        '$routeServer'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}'
        '?overview=false',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        return 0;
      }

      final data = jsonDecode(response.body);

      final routes = data['routes'];
      if (routes == null || routes.isEmpty) {
        return 0;
      }

      final distanceMeters = routes[0]['distance'];
      if (distanceMeters == null) {
        return 0;
      }

      return (distanceMeters as num).toDouble() / 1000;
    } catch (e) {
      debugPrint('OSRM distance error: $e');
      return 0;
    }
  }

  /// Get Route for map line
  static Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    try {
      final uri = Uri.parse(
        '$routeServer'
        '${start.longitude},${start.latitude};'
        '${end.longitude},${end.latitude}'
        '?overview=full&geometries=geojson',
      );

      final response = await http.get(uri);

      if (response.statusCode != 200) {
        return [];
      }

      final data = jsonDecode(response.body);

      final routes = data['routes'];
      if (routes == null || routes.isEmpty) return [];

      final geometry = routes[0]['geometry'];
      if (geometry == null || geometry['coordinates'] == null) return [];

      final List<dynamic> coords = geometry['coordinates'];

      return coords
          .map<LatLng>(
            (c) => LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()),
          )
          .toList();
    } catch (e) {
      debugPrint('getRoute error: $e');
      return [];
    }
  }

  /// Get Location Name
  static Future<String> getPlaceName(
    double lat,
    double lon, {
    String lang = 'en',
  }) async {
    try {
      final uri = Uri.parse(
        '$mapServer/reverse'
        '?format=json'
        '&lat=$lat'
        '&lon=$lon'
        '&accept-language=$lang',
      );

      final response = await http.get(
        uri,
        headers: {'User-Agent': packageName},
      );

      if (response.statusCode != 200) return 'Unknown place';

      final data = jsonDecode(response.body);

      return data['display_name'] ?? 'Unknown place';
    } catch (e) {
      debugPrint('getPlaceName error: $e');
      return 'Unknown place';
    }
  }
}
