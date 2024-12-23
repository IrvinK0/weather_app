import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';

void main() {
  group('WeatherError Widget', () {
    testWidgets('displays retry button and triggers onTap when clicked',
        (tester) async {
      // Arrange
      bool tapped = false;
      onTap() {
        tapped = true;
      }

      await tester.pumpApp(WeatherError(onTap: onTap));

      expect(find.text('Retry'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(tapped, true);
    });
  });
}
