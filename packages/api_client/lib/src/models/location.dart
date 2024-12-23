/// Represents a geographic location with a name and coordinates.
class Location {
  /// The name of the location (e.g., city name).
  final String name;

  /// The latitude of the location.
  final double latitude;

  /// The longitude of the location.
  final double longitude;

  const Location({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  /// Factory method to create a [Location] instance from a JSON object.
  ///
  /// Throws [FormatException] if required fields are missing or have invalid types.
  factory Location.fromJson(Map<String, dynamic> json) {
    try {
      return Location(
        name: json['name'] as String,
        latitude: (json['lat'] as num).toDouble(),
        longitude: (json['lon'] as num).toDouble(),
      );
    } catch (e) {
      throw FormatException('Failed to parse Location: $e');
    }
  }
}

