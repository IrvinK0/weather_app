/// Represents weather information with its details.
class Weather {
  /// The unique identifier for the weather condition.
  final int id;

  /// The main weather condition (e.g., "Rain", "Clear").
  final String main;

  /// A more detailed description of the weather condition.
  final String description;

  /// The icon identifier for the weather condition.
  final String icon;

  const Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  /// Factory method to create a [Weather] instance from a JSON object.
  ///
  /// Throws [FormatException] if any required field is missing or has an invalid type.
  factory Weather.fromJson(Map<String, dynamic> json) {
    try {
      return Weather(
        id: json['id'] as int,
        main: json['main'] as String,
        description: json['description'] as String,
        icon: json['icon'] as String,
      );
    } catch (e) {
      throw FormatException('Failed to parse Weather: $e');
    }
  }
}
