import 'package:api_client/api_client.dart';
import 'package:test/test.dart';

void main() {
  group('Weather', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      const weather = Weather(
        id: 500,
        main: 'Rain',
        description: 'light rain',
        icon: '10d',
      );

      // Assert
      expect(weather.id, equals(500));
      expect(weather.main, equals('Rain'));
      expect(weather.description, equals('light rain'));
      expect(weather.icon, equals('10d'));
    });

    test('fromJson should parse correctly', () {
      // Arrange
      final json = {
        'id': 500,
        'main': 'Rain',
        'description': 'light rain',
        'icon': '10d',
      };

      // Act
      final weather = Weather.fromJson(json);

      // Assert
      expect(weather.id, 500);
      expect(weather.main, 'Rain');
      expect(weather.description, 'light rain');
      expect(weather.icon, '10d');
    });

    test('fromJson should throw an error for missing fields', () {
      // Arrange
      final json = {
        'id': 500,
        'main': 'Rain',
        'description': 'light rain',
      };

      // Act & Assert
      expect(() => Weather.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
