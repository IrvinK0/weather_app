import 'package:api_client/api_client.dart';
import 'package:test/test.dart';

void main() {
  group('DayWeather', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      final dayWeather = DayWeather(
        dt: 1734606000,
        temp: Temperature(day: 6.76),
        pressure: 1008,
        humidity: 68,
        weather: [
          Weather(id: 500, main: 'Rain', description: 'light rain', icon: '10d')
        ],
        speed: 8.17,
      );

      // Assert
      expect(dayWeather.dt, 1734606000);
      expect(dayWeather.temp.day, 6.76);
      expect(dayWeather.pressure, 1008);
      expect(dayWeather.humidity, 68);
      expect(dayWeather.weather.length, 1);
      expect(dayWeather.weather[0].id, 500);
      expect(dayWeather.weather[0].main, 'Rain');
      expect(dayWeather.weather[0].description, 'light rain');
      expect(dayWeather.weather[0].icon, '10d');
      expect(dayWeather.speed, 8.17);
    });

    test('fromJson should parse correctly', () {
      // Arrange
      final json = {
        'dt': 1734606000,
        'temp': {'day': 6.76},
        'pressure': 1008,
        'humidity': 68,
        'weather': [
          {
            'id': 500,
            'main': 'Rain',
            'description': 'light rain',
            'icon': '10d'
          }
        ],
        'speed': 8.17,
      };

      // Act
      final dayWeather = DayWeather.fromJson(json);

      // Assert
      expect(dayWeather.dt, 1734606000);
      expect(dayWeather.temp.day, 6.76);
      expect(dayWeather.pressure, 1008);
      expect(dayWeather.humidity, 68);
      expect(dayWeather.weather.length, 1);
      expect(dayWeather.weather[0].id, 500);
      expect(dayWeather.weather[0].main, 'Rain');
      expect(dayWeather.weather[0].description, 'light rain');
      expect(dayWeather.weather[0].icon, '10d');
      expect(dayWeather.speed, 8.17);
    });

    test('fromJson should handle empty weather list', () {
      // Arrange
      final json = {
        'dt': 1734606000,
        'temp': {'day': 6.76},
        'pressure': 1008,
        'humidity': 68,
        'weather': [],
        'speed': 8.17,
      };

      // Act
      final dayWeather = DayWeather.fromJson(json);

      // Assert
      expect(dayWeather.weather.isEmpty, true);
    });

    test('fromJson should throw an error for missing fields', () {
      // Arrange
      final json = {
        'dt': 1734606000,
        'temp': {'day': 6.76},
        'humidity': 68,
        'weather': [
          {
            'id': 500,
            'main': 'Rain',
            'description': 'light rain',
            'icon': '10d'
          }
        ],
      };

      // Act & Assert
      expect(() => DayWeather.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
