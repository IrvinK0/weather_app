import 'package:api_client/api_client.dart' as api;
import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/domain/repository/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAPIClient extends Mock implements api.APIClient {}

void main() {
  group('WeatherRepository', () {
    late api.APIClient apiClient;
    late WeatherRepository repository;

    setUp(() {
      apiClient = MockAPIClient();
      repository = WeatherRepository(apiClient: apiClient);
    });

    group('searchLocation', () {
      test('calls searchLocation with correct city', () async {
        // Act & Assert
        try {
          await repository.searchLocation(query: 'city');
        } catch (_) {}
        verify(() => apiClient.searchLocation(query: 'city')).called(1);
      });

      test('searchLocation should throw LocationRequestFailure when API call fails', () async {
        when(() => apiClient.searchLocation(query: 'Test City')).thenThrow(api.LocationRequestFailure());
        expect(() => repository.searchLocation(query: 'Test City'),
          throwsA(isA<api.LocationRequestFailure>()));
    });

      test('returns correct Location', () async {
        // Arrange
        when(() => apiClient.searchLocation(query: any(named: 'query')))
            .thenAnswer((_) async =>
                api.Location(name: 'city', latitude: 1.0, longitude: 2.0));

        // Act & Assert
        final result = await repository.searchLocation(query: 'city');
        expect(result, Location(name: 'city', latitude: 1.0, longitude: 2.0));
      });
    });

    group('getForecastForLocation', () {
      test('calls getForecast with correct props', () async {
        // Act & Assert
        try {
          // Act & Assert
          await repository.getForecastForLocation(
            location: Location(name: 'Berlin', latitude: 20, longitude: 30),
            unit: Unit.metric,
          );
        } catch (_) {}
        verify(() => apiClient.getForecast(
            latitude: 20,
            longitude: 30,
            numberOfDays: 7,
            units: Unit.metric.name)).called(1);
      });

      test('throws when getForecast fails', () async {
        // Arrange
        final exception = api.ForecastRequestFailure();
        when(() => apiClient.getForecast(
            latitude: any(named: 'latitude'),
            longitude: any(named: 'longitude'),
            numberOfDays: any(named: 'numberOfDays'),
            units: any(named: 'units'))).thenThrow(exception);

        // Act & Assert
        expect(
          () async => repository.getForecastForLocation(
              location: Location(name: 'Berlin', latitude: 20, longitude: 30),
              unit: Unit.metric),
          throwsA(isA<api.ForecastRequestFailure>()));
      });

      test('returns correct List<Weather>', () async {
        // Arrange
        when(() => apiClient.getForecast(
                latitude: 10, longitude: 20, numberOfDays: 7, units: 'metric'))
            .thenAnswer((_) async => api.Forecast(list: [
                  api.DayWeather(
                    dt: 1661943600,
                    temp: api.Temperature(day: 20),
                    pressure: 1000,
                    humidity: 67,
                    weather: [
                      api.Weather(
                        id: 500,
                        main: 'Rain',
                        description: 'light rain',
                        icon: '10d',
                      )
                    ],
                    speed: 20,
                  ),
                ]));

        // Act & Assert
        final result = await repository.getForecastForLocation(
            location: Location(name: 'city', latitude: 10, longitude: 20),
            unit: Unit.metric);
        expect(result, [
          Weather(
            date: DateTime.fromMillisecondsSinceEpoch(1661943600000),
            location: Location(name: 'city', latitude: 10, longitude: 20),
            temperature: 20,
            description: 'light rain',
            icon: '10d',
            humidity: 67,
            pressure: 1000,
            wind: 20,
          )
        ]);
      });
    });

    group('getForecastForCityName', () {
      test('calls searchLocation and getForecast', () async {
        // Arrange
        when(() => apiClient.searchLocation(query: any(named: 'query')))
            .thenAnswer((_) async =>
                api.Location(name: 'city', latitude: 1.0, longitude: 2.0));

        // Act & Assert
        try {
          await repository.getForecastForCityName(
              query: 'city', unit: Unit.metric);
        } catch (_) {}
        verify(() => apiClient.searchLocation(query: 'city')).called(1);
        verify(() => apiClient.getForecast(
              latitude: 1.0,
              longitude: 2.0,
              numberOfDays: 7,
              units: 'metric',
            )).called(1);
      });
    });
  });
}
