import 'package:flaconi_weather/domain/repository/settings_repository.dart';
import 'package:flaconi_weather/domain/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    WeatherRepository? weatherRepository,
    SettingsRepository? settingsRepository,
  }) {
    return pumpWidget(
      MultiRepositoryProvider(providers: [
        RepositoryProvider.value(
            value: weatherRepository ?? MockWeatherRepository()),
        RepositoryProvider.value(
          value: settingsRepository ?? MockSettingsRepository(),
        ),
      ], child: MaterialApp(home: Scaffold(body: widget))),
    );
  }

  Future<void> pumpRoute(
    Route<dynamic> route, {
    MockWeatherRepository? weatherRepository,
  }) {
    return pumpApp(
      Navigator(onGenerateRoute: (_) => route),
      weatherRepository: weatherRepository,
    );
  }
}
