part of 'weather_forecast_bloc.dart';

enum WeatherStatus { loading, success, failure }

final class WeatherForecastState extends Equatable {
  const WeatherForecastState({
    this.status = WeatherStatus.loading,
    this.cityQuery = '',
    this.weatherList = const [],
    this.selectedIndex = 0,
    this.unit = Unit.metric,
  });

  final WeatherStatus status;
  final String cityQuery;
  final List<Weather> weatherList;
  final int selectedIndex;

  final Unit unit;

  Weather get selectedWeather => weatherList[selectedIndex];

  List<WeatherItemData> get weatherItemData => weatherList
      .map((weather) => WeatherItemData(
            topText: weather.dayShort,
            icon: weather.icon,
            bottomText: formattedTemperature(
              weather.temperature,
              unit,
            ),
          ))
      .toList();

  WeatherDetailsData get weatherDetailsData => WeatherDetailsData(
        topText: selectedWeather.day,
        middleText: selectedWeather.description,
        icon: selectedWeather.icon,
        middleText1: formattedTemperature(selectedWeather.temperature, unit),
        bottomText: formattedHumidity(selectedWeather.humidity),
        bottomText1: formattedPressure(selectedWeather.pressure),
        bottomText2: formattedWindSpeed(selectedWeather.wind, unit),
      );

  WeatherForecastState copyWith({
    WeatherStatus? status,
    String? cityQuery,
    List<Weather>? weatherList,
    int? selectedIndex,
    Unit? unit,
  }) {
    return WeatherForecastState(
      status: status ?? this.status,
      cityQuery: cityQuery ?? this.cityQuery,
      weatherList: weatherList ?? this.weatherList,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      unit: unit ?? this.unit,
    );
  }

  @override
  List<Object?> get props =>
      [status, cityQuery, weatherList, selectedIndex, unit];
}
