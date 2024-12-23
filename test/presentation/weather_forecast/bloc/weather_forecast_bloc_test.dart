import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/domain/repository/settings_repository.dart';
import 'package:flaconi_weather/domain/repository/weather_repository.dart';
import 'package:flaconi_weather/presentation/weather_forecast/bloc/weather_forecast_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group('WeatherForecastBloc', () {
    late WeatherRepository weatherRepository;
    late SettingsRepository settingsRepository;
    late WeatherForecastBloc bloc;

    var mockWeather = Weather(
      date: DateTime.now(),
      location: const Location(
        name: 'Berlin',
        latitude: 52.52,
        longitude: 13.405,
      ),
      temperature: 20.0,
      description: 'Sunny',
      icon: '01d',
      humidity: 60,
      pressure: 1012,
      wind: 5,
    );

    setUp(() {
      weatherRepository = MockWeatherRepository();
      settingsRepository = MockSettingsRepository();
      when(() => settingsRepository.settings)
          .thenAnswer((_) => Settings(unit: Unit.metric));

      bloc = WeatherForecastBloc(
          weatherRepository: weatherRepository,
          settingsRepository: settingsRepository,
          query: 'Berlin');

      registerFallbackValue(Unit.metric);
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is WeatherForecastState', () {
      expect(bloc.state, const WeatherForecastState(cityQuery: 'Berlin'));
    });

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      'emits [loading, success], cityQuery and weatherList when fetchWeatherForecast succeeds',
      build: () {
        when(() => weatherRepository.getForecastForCityName(
              query: any(named: 'query'),
              unit: any(named: 'unit'),
            )).thenAnswer((_) async => [mockWeather]);
        when(() => settingsRepository.getSettings())
            .thenAnswer((_) => Stream.empty());
        return bloc;
      },
      act: (cubit) => cubit.add(WeatherForecastFetchEvent()),
      expect: () => [
        const WeatherForecastState(
            status: WeatherStatus.loading, cityQuery: 'Berlin'),
        WeatherForecastState(
            status: WeatherStatus.success,
            cityQuery: 'Berlin',
            weatherList: [mockWeather]),
      ],
      verify: (_) {
        verify(() => weatherRepository.getForecastForCityName(
              query: 'Berlin',
              unit: Unit.metric,
            )).called(1);
      },
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      'emits [loading, failure] when fetchWeatherForecast fails',
      build: () {
        when(() => weatherRepository.getForecastForCityName(
              query: any(named: 'query'),
              unit: any(named: 'unit'),
            )).thenThrow(Exception('Failed to fetch weather'));
        when(() => settingsRepository.getSettings())
            .thenAnswer((_) => Stream.empty());
        return bloc;
      },
      act: (cubit) => cubit.add(WeatherForecastFetchEvent()),
      expect: () => [
        const WeatherForecastState(
            status: WeatherStatus.loading, cityQuery: 'Berlin'),
        const WeatherForecastState(
            status: WeatherStatus.failure, cityQuery: 'Berlin'),
      ],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      'emits [unit] and [weatherList] when settingsRepository emits received new event',
      build: () {
        when(() => weatherRepository.getForecastForCityName(
              query: any(named: 'query'),
              unit: any(named: 'unit'),
            )).thenAnswer((_) async => [mockWeather]);
        when(() => settingsRepository.getSettings()).thenAnswer((_) =>
            Stream.fromIterable(
                [Settings(unit: Unit.metric), Settings(unit: Unit.imperial)]));
        return bloc;
      },
      act: (cubit) => cubit.add(WeatherForecastSubscribeToSettingsEvent()),
      expect: () => [
        const WeatherForecastState(
            status: WeatherStatus.loading,
            cityQuery: 'Berlin',
            unit: Unit.imperial),
        WeatherForecastState(
            status: WeatherStatus.success,
            cityQuery: 'Berlin',
            weatherList: [mockWeather],
            unit: Unit.imperial),
      ],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      'does not emit new states when query is empty',
      build: () => WeatherForecastBloc(
          weatherRepository: weatherRepository,
          settingsRepository: settingsRepository,
          query: ''),
      act: (cubit) => cubit.add(WeatherForecastFetchEvent()),
      expect: () => [],
    );

    blocTest<WeatherForecastBloc, WeatherForecastState>(
      'emits new selected index when selectItem',
      build: () => bloc,
      act: (cubit) => cubit.add(WeatherForecastSelectItemEvent(index: 1)),
      expect: () => [
        const WeatherForecastState(selectedIndex: 1, cityQuery: 'Berlin'),
      ],
    );
  });
}
