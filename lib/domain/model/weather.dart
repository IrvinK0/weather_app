import 'package:equatable/equatable.dart';

import '../../core/helpers/datetime_format.dart';
import 'models.dart';

class Weather extends Equatable {
  Weather({
    required this.date,
    required this.location,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.pressure,
    required this.wind,
  })  : dayShort = formattedShortDay(date),
        day = formattedDay(date);

  final DateTime date;
  final Location location;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final int pressure;
  final double wind;

  final String dayShort;
  final String day;

  @override
  List<Object> get props => [
        date,
        location,
        temperature,
        description,
        icon,
        humidity,
        pressure,
        wind,
      ];
}
