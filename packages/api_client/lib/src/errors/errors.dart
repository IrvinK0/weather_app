/// Exception thrown when the forecast request to the OpenWeatherMap API fails.
class ForecastRequestFailure implements Exception {}

/// Exception thrown when the forecast data is not found in the API response.
class ForecastNotFoundFailure implements Exception {}

/// Exception thrown when the search location request to the OpenWeatherMap API fails.
class LocationRequestFailure implements Exception {}

/// Exception thrown when the location data is not found in the API response.
class LocationNotFoundFailure implements Exception {}