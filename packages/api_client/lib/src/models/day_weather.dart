import 'temperature.dart';
import 'weather.dart';

/// Represents the weather details for a specific day.
class DayWeather {
  /// The timestamp for the day's weather data.
  final int dt;

  /// The temperature details for the day.
  final Temperature temp;

  /// Atmospheric pressure in hPa.
  final int pressure;

  /// Humidity percentage.
  final int humidity;

  /// List of weather conditions for the day.
  final List<Weather> weather;

  /// Wind speed in [Unit].
  final double speed;

  DayWeather({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.weather,
    required this.speed,
  });

  /// Factory method to create a [DayWeather] instance from a JSON object.
  ///
  /// Throws [FormatException] if any required field is missing or invalid.
  factory DayWeather.fromJson(Map<String, dynamic> json) {
    try {
      return DayWeather(
        dt: json['dt'] as int,
        temp: Temperature.fromJson(json['temp']),
        pressure: json['pressure'] as int,
        humidity: json['humidity'] as int,
        weather: (json['weather'] as List<dynamic>)
            .map((e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        speed: (json['speed'] as num).toDouble(),
      );
    } catch (e) {
      throw FormatException('Failed to parse DayWeather: $e');
    }
  }
}
