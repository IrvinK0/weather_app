import 'dart:async';
import 'dart:convert';

import 'package:api_client/api_client.dart';
import 'package:http/http.dart' as http;

/// A client for interacting with the OpenWeatherMap API to fetch weather forecasts and search locations.
final class OpenWeatherMapAPIClient extends APIClient {
  /// Creates an instance of [OpenWeatherMapAPIClient].
  ///
  /// - [baseUrl]: The base URL of the OpenWeatherMap API.
  /// - [appId]: The API key for authenticating requests.
  /// - [httpClient]: An optional [http.Client] instance for making HTTP requests.
  ///   Defaults to a new [http.Client] if not provided.
  OpenWeatherMapAPIClient({
    required String baseUrl,
    required String appId,
    http.Client? httpClient,
  })  : _baseUrl = baseUrl,
        _appId = appId,
        _httpClient = httpClient ?? http.Client();

  /// The base URL for the OpenWeatherMap API.
  final String _baseUrl;

  /// The API key used for authentication.
  final String _appId;

  /// The HTTP client used to perform requests.
  final http.Client _httpClient;

  /// Fetches the weather forecast for the specified location and parameters.
  ///
  /// - [latitude]: The latitude of the location.
  /// - [longitude]: The longitude of the location.
  /// - [numberOfDays]: The number of days of forecast data to fetch.
  /// - [units]: The unit system to use for the forecast (e.g., "metric" or "imperial").
  ///
  /// Throws a [ForecastRequestFailure] if the API request fails.
  /// Throws a [ForecastNotFoundFailure] if the forecast data is not found in the response.
  ///
  /// Returns a [Forecast] object containing the weather forecast data.
  @override
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
    required int numberOfDays,
    required String units,
  }) async {
    final uri = Uri.https(_baseUrl, 'data/2.5/forecast/daily', {
      'lat': latitude.toString(),
      'lon': longitude.toString(),
      'cnt': numberOfDays.toString(),
      'units': units,
      'appid': _appId,
    });

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw ForecastRequestFailure();
    }

    final Map<String, dynamic> json;
    try {
      json = jsonDecode(response.body) as Map<String, dynamic>;
    } catch (e) {
      throw ForecastRequestFailure();
    }

    if (!json.containsKey('list') || json['list'] == null) {
      throw ForecastNotFoundFailure();
    }

    return Forecast.fromJson(json);
  }

  /// Searches for a location using the provided query string and retrieves its details.
  ///
  /// - [query]: The search term used to find the location.
  ///
  /// Throws a [LocationRequestFailure] if the API request fails.
  /// Throws a [LocationNotFoundFailure] if no matching location is found.
  ///
  /// Returns a [Location] object representing the first matching location.
  @override
  Future<Location> searchLocation({required String query}) async {
    final uri = Uri.https(_baseUrl, 'geo/1.0/direct', {
      'q': query,
      'limit': '1',
      'appid': _appId,
    });

    final response = await _httpClient.get(uri);

    if (response.statusCode != 200) {
      throw LocationRequestFailure();
    }

    final dynamic json;
    try {
      json = jsonDecode(response.body);
    } catch (e) {
      throw LocationRequestFailure();
    }

    if (json is List && json.isNotEmpty) {
      return Location.fromJson(json.first as Map<String, dynamic>);
    } else {
      throw LocationNotFoundFailure();
    }
  }
}
