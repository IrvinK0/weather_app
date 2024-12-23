import 'package:bloc_test/bloc_test.dart';
import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/presentation/weather_forecast/bloc/weather_forecast_bloc.dart';
import 'package:flaconi_weather/presentation/weather_forecast/view/view.dart';
import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../pump_app.dart';

class MockWeatherForecastBloc extends MockCubit<WeatherForecastState>
    implements WeatherForecastBloc {}

void main() {
  group('WeatherForecastView', () {
    late WeatherForecastBloc bloc;

    setUp(() {
      bloc = MockWeatherForecastBloc();
    });

    Widget buildSubject() {
      return BlocProvider.value(
        value: bloc,
        child: const WeatherForecastView(),
      );
    }

    testWidgets(
      'renders AppBar with title',
      (tester) async {
        when(() => bloc.state).thenReturn(
            const WeatherForecastState(cityQuery: 'Berlin', unit: Unit.metric));

        await tester.pumpApp(buildSubject());

        expect(find.byType(AppBar), findsOneWidget);

        expect(
          find.descendant(
            of: find.byType(AppBar),
            matching: find.text('Berlin'),
          ),
          findsOneWidget,
        );
      },
    );

    testWidgets('renders WeatherLoading when state is loading',
        (WidgetTester tester) async {
      when(() => bloc.state).thenReturn(const WeatherForecastState(
          status: WeatherStatus.loading, unit: Unit.metric));

      await tester.pumpApp(buildSubject());

      expect(find.byType(WeatherLoading), findsOneWidget);
    });

    testWidgets('renders WeatherError when state is failure',
        (WidgetTester tester) async {
      when(() => bloc.state).thenReturn(const WeatherForecastState(
          status: WeatherStatus.failure, unit: Unit.metric));

      await tester.pumpApp(buildSubject());

      expect(find.byType(WeatherError), findsOneWidget);
    });

    testWidgets('renders WeatherDetails and ForecastList when state is success',
        (WidgetTester tester) async {
      when(() => bloc.state).thenReturn(WeatherForecastState(
          status: WeatherStatus.success,
          weatherList: [
            Weather(
              date: DateTime(2024, 1, 1),
              location:
                  Location(name: 'Berlin', latitude: 23.02, longitude: 45.4),
              temperature: 25.5,
              description: 'Clear sky',
              icon: '01d',
              humidity: 60,
              pressure: 1013,
              wind: 5,
            ),
          ],
          unit: Unit.metric));

      await mockNetworkImagesFor(() => tester.pumpApp(buildSubject()));

      expect(find.byType(WeatherDetails), findsOneWidget);
      expect(find.byType(ForecastList), findsOneWidget);
    });
  });
}
