part of 'weather_forecast_bloc.dart';

sealed class WeatherForecastEvent extends Equatable {
  const WeatherForecastEvent();

  @override
  List<Object> get props => [];
}

final class WeatherForecastFetchEvent extends WeatherForecastEvent {
  const WeatherForecastFetchEvent();
}

final class WeatherForecastSubscribeToSettingsEvent
    extends WeatherForecastEvent {
  const WeatherForecastSubscribeToSettingsEvent();
}

final class WeatherForecastSelectItemEvent extends WeatherForecastEvent {
  const WeatherForecastSelectItemEvent({
    required this.index,
  });

  final int index;

  @override
  List<Object> get props => [index];
}
