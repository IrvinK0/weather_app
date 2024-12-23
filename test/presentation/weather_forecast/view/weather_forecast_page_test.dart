import 'package:bloc_test/bloc_test.dart';
import 'package:flaconi_weather/domain/model/unit.dart';
import 'package:flaconi_weather/presentation/weather_forecast/bloc/weather_forecast_bloc.dart';
import 'package:flaconi_weather/presentation/weather_forecast/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../pump_app.dart';

class MockWeatherForecastCubit extends MockCubit<WeatherForecastState>
    implements WeatherForecastBloc {}

void main() {
  group('WeatherForecastPage', () {
    late WeatherForecastBloc cubit;

    setUp(() {
      cubit = MockWeatherForecastCubit();

      when(() => cubit.state).thenReturn(
        WeatherForecastState(unit: Unit.metric),
      );
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: cubit,
        child: const WeatherForecastPage(),
      );
    }

    testWidgets('renders WeatherForecastView', (WidgetTester tester) async {
      await tester.pumpApp(buildSubject());

      expect(find.byType(WeatherForecastView), findsOneWidget);
    });
  });
}
