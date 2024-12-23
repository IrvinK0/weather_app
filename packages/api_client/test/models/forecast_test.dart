import 'package:test/test.dart';
import 'package:api_client/api_client.dart';

void main() {
  group('Forecast', () {
    test('Constructor initializes properties correctly', () {
      // Arrange
      final forecast = Forecast(list: [
        DayWeather(
          dt: 1734606000,
          temp: Temperature(day: 6.76),
          pressure: 1008,
          humidity: 68,
          weather: [
            Weather(
              id: 500,
              main: 'Rain',
              description: 'light rain',
              icon: '10d',
            )
          ],
          speed: 8.17,
        )
      ]);

      // Assert
      expect(forecast.list.length, 1);
      expect(forecast.list[0].dt, 1734606000);
      expect(forecast.list[0].temp.day, 6.76);
    });

    test('fromJson should parse correctly', () {
      // Arrange
      final json = {
        'list': [
          {
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
          },
          {
            'dt': 1734692400,
            'temp': {'day': 7.28},
            'pressure': 1012,
            'humidity': 70,
            'weather': [
              {
                'id': 501,
                'main': 'Rain',
                'description': 'moderate rain',
                'icon': '10n'
              }
            ],
            'speed': 5.5,
          },
        ],
      };

      // Act
      final forecast = Forecast.fromJson(json);

      // Assert
      expect(forecast.list.length, 2);

      // Verify first DayWeather object
      final firstDayWeather = forecast.list[0];
      expect(firstDayWeather.dt, 1734606000);
      expect(firstDayWeather.temp.day, 6.76);
      expect(firstDayWeather.pressure, 1008);
      expect(firstDayWeather.humidity, 68);
      expect(firstDayWeather.weather.length, 1);
      expect(firstDayWeather.weather[0].id, 500);
      expect(firstDayWeather.speed, 8.17);

      // Verify second DayWeather object
      final secondDayWeather = forecast.list[1];
      expect(secondDayWeather.dt, 1734692400);
      expect(secondDayWeather.temp.day, 7.28);
      expect(secondDayWeather.pressure, 1012);
      expect(secondDayWeather.humidity, 70);
      expect(secondDayWeather.weather.length, 1);
      expect(secondDayWeather.weather[0].id, 501);
      expect(secondDayWeather.speed, 5.5);
    });

    test('fromJson should handle empty list', () {
      // Arrange
      final json = {
        'list': [],
      };

      // Act
      final forecast = Forecast.fromJson(json);

      // Assert
      expect(forecast.list.isEmpty, true);
    });

    test('fromJson should throw an error for missing list field', () {
      // Arrange
      final Map<String, dynamic> json = {};

      // Act & Assert
      expect(() => Forecast.fromJson(json), throwsA(isA<FormatException>()));
    });
  });
}
