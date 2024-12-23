import 'package:api_client/api_client.dart' as api;

import '../model/models.dart';

/// Repository responsible for fetching weather-related data.
/// This class acts as an abstraction layer between the domain layer
/// and the API client, providing methods to search locations
/// and retrieve weather forecasts.
class WeatherRepository {
  /// Creates an instance of [WeatherRepository] with the required [APIClient].
  WeatherRepository({required api.APIClient apiClient}) : _apiClient = apiClient;

  /// The API client used to make network requests.
  final api.APIClient _apiClient;

  /// Searches for a location by its name or query string.
  ///
  /// This method uses the [_apiClient] to fetch location data from the API.
  /// Returns a [Location] object that contains the name, latitude, and longitude
  /// of the location.
  ///
  /// Throws:
  /// - `LocationNotFoundFailure` if no matching location is found.
  /// - `LocationRequestFailure` for other API-related errors.
  Future<Location> searchLocation({required String query}) async {
    try {
      final searchData = await _apiClient.searchLocation(query: query);
      return Location(
        name: searchData.name,
        latitude: searchData.latitude,
        longitude: searchData.longitude,
      );
    } catch (e) {
      throw api.LocationRequestFailure();  // Custom error handling
    }
  }

  /// Helper method to map forecast data from the API response to the Weather model.
  List<Weather> _mapForecastData({
    required List<dynamic> forecastData,
    required Location location,
  }) {
    return forecastData.map((value) {
      final weatherData = value.weather.isNotEmpty ? value.weather.first : null;
      return Weather(
        date: DateTime.fromMillisecondsSinceEpoch(value.dt * 1000),
        location: location,
        temperature: value.temp.day,
        description: weatherData?.description ?? 'No description',
        icon: weatherData?.icon ?? '',
        humidity: value.humidity,
        pressure: value.pressure,
        wind: value.speed,
      );
    }).toList();
  }

  /// Retrieves a 7-day weather forecast for a given location and unit system.
  ///
  /// This method fetches forecast data from the API using the location's
  /// latitude and longitude, and the specified units (e.g., metric or imperial).
  ///
  /// Returns a list of [Weather] objects, each representing the forecast
  /// for a specific day.
  ///
  /// Throws:
  /// - `ForecastRequestFailure` if the API call fails.
  /// - `ForecastNotFoundFailure` if the forecast data is missing.
  Future<List<Weather>> getForecastForLocation({
    required Location location,
    required Unit unit,
  }) async {
    try {
      final forecastData = await _apiClient.getForecast(
        latitude: location.latitude,
        longitude: location.longitude,
        numberOfDays: 7,
        units: unit.name,
      );

      if (forecastData.list.isEmpty) {
        throw api.ForecastNotFoundFailure();
      }

      return _mapForecastData(forecastData: forecastData.list, location: location);
    } catch (e) {
      throw api.ForecastRequestFailure();  // Custom error handling
    }
  }

  /// Retrieves a 7-day weather forecast for a city by its name.
  ///
  /// This method first searches for the location using the city name (query string)
  /// and then fetches the weather forecast for the resulting location and the specified unit (e.g., metric or imperial).
  ///
  /// Returns a list of [Weather] objects, each representing the forecast
  /// for a specific day.
  ///
  /// Throws:
  /// - `LocationNotFoundFailure` if no matching location is found.
  /// - `LocationRequestFailure` for other API-related errors.
  /// - `ForecastRequestFailure` if the API call for the forecast fails.
  /// - `ForecastNotFoundFailure` if the forecast data is missing.
  Future<List<Weather>> getForecastForCityName({
    required String query,
    required Unit unit,
  }) async {
    try {
      final location = await searchLocation(query: query);
      return await getForecastForLocation(location: location, unit: unit);
    } catch (e) {
      rethrow;  // Re-throwing caught exceptions
    }
  }
}
