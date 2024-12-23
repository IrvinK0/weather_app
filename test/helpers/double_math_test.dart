import 'package:flaconi_weather/core/helpers/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('convertMetersPerSecondToKilometersPerHour', () {
    test('converts m/s to km/h correctly', () {
      expect(convertMetersPerSecondToKilometersPerHour(0.0), 0.0);
      expect(convertMetersPerSecondToKilometersPerHour(1.0), 3.6);
      expect(convertMetersPerSecondToKilometersPerHour(5.0), 18.0);
      expect(convertMetersPerSecondToKilometersPerHour(10.0), 36.0);
    });
  });
}
