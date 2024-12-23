import '../../domain/model/models.dart';
import 'helpers.dart';

String formattedTemperature(double value, Unit unit) =>
    '${value.round()}${unit == Unit.metric ? '°C' : '°F'}';
String formattedHumidity(int value) => 'Humidity: $value%';
String formattedPressure(int value) => 'Pressure: $value hPa';
String formattedWindSpeed(double value, Unit unit) {
  if (unit == Unit.metric) {
    return 'Wind: ${convertMetersPerSecondToKilometersPerHour(value).round()} km/h';
  } else {
    return 'Wind: ${value.round()} miles/hour';
  }
}
