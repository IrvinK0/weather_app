import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Weather', () {
    // Arrange
    final weather = Weather(
      date: DateTime(2024, 1, 1),
      location: Location(name: 'Berlin', latitude: 23.02, longitude: 45.4),
      temperature: 25.5,
      description: 'Clear sky',
      icon: '01d',
      humidity: 60,
      pressure: 1013,
      wind: 5,
    );

    test('props contains all properties', () {
      // Act & Assert
      expect(
        weather.props,
        equals([
          DateTime(2024, 1, 1),
          Location(name: 'Berlin', latitude: 23.02, longitude: 45.4),
          25.5,
          'Clear sky',
          '01d',
          60,
          1013,
          5,
        ]),
      );
      expect(weather.dayShort, 'Mon');
      expect(weather.day, 'Monday');
    });

    test('supports value equality', () {
      // Arrange
      final weatherCopy = Weather(
        date: DateTime(2024, 1, 1),
        location: Location(name: 'Berlin', latitude: 23.02, longitude: 45.4),
        temperature: 25.5,
        description: 'Clear sky',
        icon: '01d',
        humidity: 60,
        pressure: 1013,
        wind: 5,
      );

      // Assert
      expect(weather, equals(weatherCopy));
    });

    test('props are different for different Weather instances', () {
      // Arrange
      final differentWeather = Weather(
        date: DateTime(2024, 1, 2), // Different date
        location: Location(name: 'Berlin', latitude: 23.02, longitude: 45.4),
        temperature: 25.5,
        description: 'Clear sky',
        icon: '01d',
        humidity: 60,
        pressure: 1013,
        wind: 5,
      );

      // Assert
      expect(weather == differentWeather, isFalse);
    });
  });
}
