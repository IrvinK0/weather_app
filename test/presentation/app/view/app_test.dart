import 'package:flaconi_weather/core/theme/theme.dart';
import 'package:flaconi_weather/domain/repository/settings_repository.dart';
import 'package:flaconi_weather/domain/repository/weather_repository.dart';
import 'package:flaconi_weather/presentation/app/view/app.dart';
import 'package:flaconi_weather/presentation/search/view/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  late WeatherRepository weatherRepository;
  late SettingsRepository settingsRepository;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    settingsRepository = MockSettingsRepository();
  });

  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(App(
        weatherRepository: weatherRepository,
        settingsRepository: settingsRepository,
      ));

      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders MaterialApp with correct themes and home',
        (tester) async {
      await tester.pumpWidget(
        RepositoryProvider.value(
          value: weatherRepository,
          child: const AppView(),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, equals(FlaconiTheme.light));
      expect(materialApp.darkTheme, equals(FlaconiTheme.dark));
      expect(find.byType(SearchPage), findsOneWidget);
    });
  });
}
