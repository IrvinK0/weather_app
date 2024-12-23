import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';

void main() {
  group('WeatherLoading', () {
    testWidgets('renders loading text and CircularProgressIndicator',
        (WidgetTester tester) async {
      await tester.pumpApp(WeatherLoading());

      expect(find.text('Loading weather forecast'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Spacer), findsNWidgets(2));
    });
  });
}
