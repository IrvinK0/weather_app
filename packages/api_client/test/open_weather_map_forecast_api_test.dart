import 'package:api_client/api_client.dart';
import 'package:api_client/src/client/open_weather_map_api_client.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'dart:convert';

class MockHttpClient extends Mock implements http.Client {}

class MockResponse extends Mock implements http.Response {}

class FakeUri extends Fake implements Uri {}

void main() {
  group('OpenWeatherMapForecastApi', () {
    late MockHttpClient mockHttpClient;
    late OpenWeatherMapAPIClient apiClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
      apiClient = OpenWeatherMapAPIClient(
        baseUrl: 'api.openweathermap.org',
        appId: 'appid',
        httpClient: mockHttpClient,
      );

      registerFallbackValue(FakeUri());
    });

    group('constructor', () {
      test('does not require an httpClient', () {
        expect(OpenWeatherMapAPIClient(baseUrl: '', appId: ''), isNotNull);
      });
    });

    group('getForecast', () {
      test('getForecast makes correct HTTP request', () async {
        // Arrange
        const latitude = 40.7128;
        const longitude = -74.0060;
        const numberOfDays = 7;
        const units = 'metric';
        const appid = 'appid';

        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
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
                }
              ]
            }),
            200,
          ),
        );

        // Act
        await apiClient.getForecast(
          latitude: latitude,
          longitude: longitude,
          numberOfDays: numberOfDays,
          units: units,
        );

        // Assert
        final capturedUri = verify(() => mockHttpClient.get(captureAny()))
            .captured
            .single as Uri;
        expect(capturedUri.scheme, 'https');
        expect(capturedUri.host, 'api.openweathermap.org');
        expect(capturedUri.path, '/data/2.5/forecast/daily');
        expect(capturedUri.queryParameters['lat'], '$latitude');
        expect(capturedUri.queryParameters['lon'], '$longitude');
        expect(capturedUri.queryParameters['cnt'], '$numberOfDays');
        expect(capturedUri.queryParameters['units'], units);
        expect(capturedUri.queryParameters['appid'], appid);
      });

      test('getForecast throws ForecastRequestFailure for non-200 response',
          () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('', 404));

        // Act & Assert
        expect(
          () async => await apiClient.getForecast(
            latitude: 40.7128,
            longitude: -74.0060,
            numberOfDays: 7,
            units: 'metric',
          ),
          throwsA(isA<ForecastRequestFailure>()),
        );
      });

      test('getForecast throws ForecastNotFoundFailure when "list" is missing',
          () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('{}', 200));

        // Act & Assert
        expect(
          () async => await apiClient.getForecast(
            latitude: 40.7128,
            longitude: -74.0060,
            numberOfDays: 7,
            units: 'metric',
          ),
          throwsA(isA<ForecastNotFoundFailure>()),
        );
      });

      test('getForecast parses response correctly', () async {
        // Arrange
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(
            jsonEncode({
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
                }
              ]
            }),
            200,
          ),
        );

        // Act
        final forecast = await apiClient.getForecast(
          latitude: 40.7128,
          longitude: -74.0060,
          numberOfDays: 7,
          units: 'metric',
        );

        // Assert
        expect(forecast.list.length, 1);
        final dayWeather = forecast.list[0];
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
    });

    group('searchLocation', () {
      test('searchLocation makes correct HTTP request', () async {
        // Arrange
        const query = 'Berlin';
        const appid = 'appid';

        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(
            jsonEncode([
              {
                'name': 'Berlin',
                'lat': 34.45,
                'lon': 32.22,
              }
            ]),
            200,
          ),
        );

        // Act
        await apiClient.searchLocation(query: query);

        // Assert
        final capturedUri = verify(() => mockHttpClient.get(captureAny()))
            .captured
            .single as Uri;
        expect(capturedUri.scheme, 'https');
        expect(capturedUri.host, 'api.openweathermap.org');
        expect(capturedUri.path, '/geo/1.0/direct');
        expect(capturedUri.queryParameters['q'], query);
        expect(capturedUri.queryParameters['limit'], '1');
        expect(capturedUri.queryParameters['appid'], appid);
      });

      test('searchLocation throws LocationRequestFailure for non-200 response',
          () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('', 404));

        // Act & Assert
        expect(
          () async => await apiClient.searchLocation(query: 'query'),
          throwsA(isA<LocationRequestFailure>()),
        );
      });

      test(
          'searchLocation throws LocationNotFoundFailure when result is missing',
          () async {
        // Arrange
        when(() => mockHttpClient.get(any()))
            .thenAnswer((_) async => http.Response('{}', 200));

        // Act & Assert
        expect(
          () async => await apiClient.searchLocation(query: 'q'),
          throwsA(isA<LocationNotFoundFailure>()),
        );
      });

      test('searchLocation parses response correctly', () async {
        // Arrange
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(
            jsonEncode([
              {
                'name': 'Berlin',
                'lat': 34.45,
                'lon': 32.22,
              }
            ]),
            200,
          ),
        );

        // Act
        final location = await apiClient.searchLocation(query: 'query');

        // Assert
        expect(location.name, 'Berlin');
        expect(location.latitude, 34.45);
        expect(location.longitude, 32.22);
      });
    });
  });
}
