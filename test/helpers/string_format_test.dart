import 'package:flaconi_weather/core/helpers/helpers.dart';
import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formattedTemperature', () {
    test('formats temperature in Celsius for metric unit', () {
      expect(formattedTemperature(25.5, Unit.metric), '26°C');
    });

    test('formats temperature in Fahrenheit for imperial unit', () {
      expect(formattedTemperature(72.8, Unit.imperial), '73°F');
    });

    test('handles negative temperatures correctly', () {
      expect(formattedTemperature(-5.7, Unit.metric), '-6°C');
    });
  });

  group('formattedHumidity', () {
    test('formats humidity value with percentage', () {
      expect(formattedHumidity(65), 'Humidity: 65%');
    });

    test('formats zero humidity correctly', () {
      expect(formattedHumidity(0), 'Humidity: 0%');
    });
  });

  group('formattedPressure', () {
    test('formats pressure value with hPa', () {
      expect(formattedPressure(1013), 'Pressure: 1013 hPa');
    });

    test('formats low pressure values correctly', () {
      expect(formattedPressure(980), 'Pressure: 980 hPa');
    });
  });

  group('formattedWindSpeed', () {
    test('formats wind speed in km/h for metric unit', () {
      expect(formattedWindSpeed(10.0, Unit.metric), 'Wind: 36 km/h');
    });

    test('formats wind speed in miles/hour for imperial unit', () {
      expect(formattedWindSpeed(10.0, Unit.imperial), 'Wind: 10 miles/hour');
    });

    test('handles zero wind speed for both units', () {
      expect(formattedWindSpeed(0, Unit.metric), 'Wind: 0 km/h');
      expect(formattedWindSpeed(0, Unit.imperial), 'Wind: 0 miles/hour');
    });

    test('handles fractional wind speed for metric unit', () {
      expect(formattedWindSpeed(3.5, Unit.metric), 'Wind: 13 km/h');
    });
  });
}
