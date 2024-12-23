import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repository/settings_repository.dart';
import '../../../domain/repository/weather_repository.dart';
import '../bloc/weather_forecast_bloc.dart';
import 'weather_forecast_view.dart';

class WeatherForecastPage extends StatelessWidget {
  const WeatherForecastPage({super.key});

  // Refactor route method to handle bloc creation and events separately.
  static Route<String> route({required String query}) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider<WeatherForecastBloc>(
          create: (context) {
            final weatherRepository = context.read<WeatherRepository>();
            final settingsRepository = context.read<SettingsRepository>();

            // Create the bloc with the required dependencies and events
            final bloc = WeatherForecastBloc(
              weatherRepository: weatherRepository,
              settingsRepository: settingsRepository,
              query: query,
            );

            // Emit events after the bloc is created
            bloc.add(WeatherForecastFetchEvent());
            bloc.add(WeatherForecastSubscribeToSettingsEvent());
            return bloc;
          },
          child: const WeatherForecastPage(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // WeatherForecastView should display the weather data accordingly
    return const WeatherForecastView();
  }
}

