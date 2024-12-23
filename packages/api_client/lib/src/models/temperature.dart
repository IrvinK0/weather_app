/// Represents the temperature for a specific day.
class Temperature {
  /// The daytime temperature in degrees.
  final double day;

  const Temperature({required this.day});

  /// Factory method to create a [Temperature] instance from a JSON object.
  ///
  /// Throws [FormatException] if the required field is missing or has an invalid type.
  factory Temperature.fromJson(Map<String, dynamic> json) {
    try {
      return Temperature(
        day: (json['day'] as num).toDouble(),
      );
    } catch (e) {
      throw FormatException('Failed to parse Temperature: $e');
    }
  }
}
