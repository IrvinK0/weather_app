import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Location', () {
    // Arrange
    final location = Location(
      name: 'San Francisco',
      latitude: 37.7749,
      longitude: -122.4194,
    );

    test('props contains all properties', () {
      expect(
        location.props,
        equals(['San Francisco', 37.7749, -122.4194]),
      );
    });

    test('supports value equality', () {
      final locationCopy = Location(
          name: 'San Francisco', latitude: 37.7749, longitude: -122.4194);

      expect(location, equals(locationCopy));
    });

    test('props are different for different Location instances', () {
      final differentLocation = Location(
        name: 'New York', // Different name
        latitude: 40.7128,
        longitude: -74.0060,
      );

      expect(location == differentLocation, isFalse);
    });
  });
}
