import 'package:flutter/material.dart' show IconData, Icons;

class Weather {
  const Weather({
    required this.temperature,
    required this.windSpeed,
    required this.code,
  });

  final double temperature;
  final double windSpeed;
  final int code;

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['current'] as Map<String, dynamic>;
    return Weather(
      temperature: (current['temperature_2m'] as num).toDouble(),
      windSpeed: (current['wind_speed_10m'] as num).toDouble(),
      code: current['weather_code'] as int,
    );
  }

  /// Libellé lisible à partir du code WMO.
  String get label => switch (code) {
    0 => 'Clear sky',
    1 || 2 || 3 => 'Partly cloudy',
    45 || 48 => 'Fog',
    >= 51 && <= 67 => 'Drizzle / rain',
    >= 71 && <= 77 => 'Snow',
    >= 80 && <= 82 => 'Showers',
    >= 95 && <= 99 => 'Thunderstorm',
    _ => 'Unknown',
  };

  /// Icône associée au code WMO.
  IconData get icon => switch (code) {
    0 => Icons.wb_sunny,
    1 || 2 || 3 => Icons.wb_cloudy,
    45 || 48 => Icons.foggy,
    >= 51 && <= 67 => Icons.grain,
    >= 71 && <= 77 => Icons.ac_unit,
    >= 80 && <= 82 => Icons.umbrella,
    >= 95 && <= 99 => Icons.thunderstorm,
    _ => Icons.help_outline,
  };
}