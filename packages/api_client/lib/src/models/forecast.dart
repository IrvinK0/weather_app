import 'day_weather.dart';

/// Represents a weather forecast containing a list of daily weather data.
class Forecast {
  /// A list of [DayWeather] objects representing daily forecasts.
  final List<DayWeather> list;

  Forecast({required this.list});

  /// Factory method to create a [Forecast] instance from a JSON object.
  ///
  /// Throws [FormatException] if the JSON data is invalid or malformed.
  factory Forecast.fromJson(Map<String, dynamic> json) {
    try {
      return Forecast(
        list: (json['list'] as List<dynamic>)
            .map((e) => DayWeather.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      throw FormatException('Failed to parse Forecast: $e');
    }
  }
}

