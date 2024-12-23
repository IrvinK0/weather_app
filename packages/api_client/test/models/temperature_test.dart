import 'package:api_client/api_client.dart';
import 'package:test/test.dart';

void main() {
  group('Temperature', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      const temperature = Temperature(day: 20);

      // Assert
      expect(temperature.day, equals(20));
    });

    test('fromJson should parse correctly', () {
      // Arrange
      final json = {
        'day': 15.5,
      };

      // Act
      final temperature = Temperature.fromJson(json);

      // Assert
      expect(temperature.day, 15.5);
    });

    test('fromJson should throw an error for missing fields', () {
      // Arrange
      final Map<String, dynamic> json = {};

      // Act & Assert
      expect(
          () => Temperature.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
