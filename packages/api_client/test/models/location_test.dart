import 'package:api_client/src/models/location.dart';
import 'package:test/test.dart';

void main() {
  group('Location', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      const location = Location(
        name: 'New York',
        latitude: 40.7128,
        longitude: -74.0060,
      );

      // Assert
      expect(location.name, equals('New York'));
      expect(location.latitude, equals(40.7128));
      expect(location.longitude, equals(-74.0060));
    });

    test('fromJson should parse correctly', () {
      // Arrange
      final json = {
        'name': 'San Francisco',
        'lat': 37.7749,
        'lon': -122.4194,
      };

      // Act
      final location = Location.fromJson(json);

      // Assert
      expect(location.name, equals('San Francisco'));
      expect(location.latitude, equals(37.7749));
      expect(location.longitude, equals(-122.4194));
    });

    test('fromJson throws an error when JSON is missing required fields', () {
      // Arrange
      final json = {
        'name': 'Los Angeles',
        // Missing 'lat' and 'lon'
      };

      // Act & Assert
      expect(() => Location.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
