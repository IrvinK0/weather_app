import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';

import 'bloc_observer.dart';
import 'core/constants/constants.dart';
import 'domain/repository/settings_repository.dart';
import 'domain/repository/weather_repository.dart';
import 'presentation/app/view/app.dart';

void bootstrap() async {
  Bloc.observer = const AppBlocObserver();

  final APIClient apiClient =
      createApiClient(baseUri: Constants.baseUri, appId: Constants.appId);
  final StorageClient storageClient =
      await createStorageClient(storageId: 'flaconi');

  final weatherRepository = WeatherRepository(apiClient: apiClient);
  final settingsRepository = SettingsRepository(storage: storageClient);

  runApp(App(
    weatherRepository: weatherRepository,
    settingsRepository: settingsRepository,
  ));
}
