import 'package:api_client/src/client/api_client.dart';
import 'src/client/open_weather_map_api_client.dart';
export 'src/models/models.dart';
export 'src/client/api_client.dart';
export 'src/errors/errors.dart';

/// Factory method to create an instance of [APIClient].
///
/// - [baseUri]: The base URI for the API.
/// - [appId]: The application ID for authentication.
/// 
/// Returns an instance of [OpenWeatherMapAPIClient].
APIClient createApiClient({required String baseUri, required String appId}) {
  assert(baseUri.isNotEmpty, 'Base URI cannot be empty.');
  assert(appId.isNotEmpty, 'App ID cannot be empty.');

  return OpenWeatherMapAPIClient(baseUrl: baseUri, appId: appId);
}

