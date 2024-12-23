import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/theme.dart';
import '../../../domain/repository/settings_repository.dart';
import '../../../domain/repository/weather_repository.dart';
import '../../search/view/search_page.dart';
import '../app_router.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.weatherRepository,
    required this.settingsRepository,
  });

  final WeatherRepository weatherRepository;
  final SettingsRepository settingsRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider.value(value: weatherRepository),
      RepositoryProvider.value(value: settingsRepository),
    ], child: const AppView());
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: FlaconiTheme.light,
      darkTheme: FlaconiTheme.dark,
      debugShowCheckedModeBanner: false,
      home: const SearchPage(),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: '/',
    );
  }
}