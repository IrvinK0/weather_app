import 'package:api_client/api_client.dart';

/// An abstract base class for API clients that provide weather and location data.
abstract class APIClient {
  /// Creates an instance of [APIClient].
  const APIClient();

  /// Fetches the weather forecast for a specific location based on the given parameters.
  ///
  /// - [latitude]: The latitude of the location.
  /// - [longitude]: The longitude of the location.
  /// - [numberOfDays]: The number of days for which the forecast is requested.
  /// - [units]: The unit system to use for the forecast (e.g., "metric" or "imperial").
  ///
  /// Returns a [Forecast] object containing weather forecast data.
  Future<Forecast> getForecast({
    required double latitude,
    required double longitude,
    required int numberOfDays,
    required String units,
  });

  /// Searches for a location based on the provided query string.
  ///
  /// - [query]: The search term used to look up the location.
  ///
  /// Returns a [Location] object representing the result of the search.
  Future<Location> searchLocation({
    required String query,
  });
}
