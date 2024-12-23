import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../pump_app.dart';

void main() {
  group('WeatherDetails Widget', () {
    testWidgets('displays weather details correctly', (tester) async {
      final weather = WeatherDetailsData(
        topText: 'topText',
        middleText: 'middleText',
        icon: 'icon',
        middleText1: 'middleText1',
        bottomText: 'bottomText',
        bottomText1: 'bottomText1',
        bottomText2: 'bottomText2',
      );

      await mockNetworkImagesFor(
          () => tester.pumpApp(WeatherDetails(data: weather)));

      expect(find.text('topText'), findsOneWidget);
      expect(find.text('middleText'), findsOneWidget);
      expect(find.text('middleText1'), findsOneWidget); // Rounded temperature
      expect(find.text('bottomText'), findsOneWidget);
      expect(find.text('bottomText1'), findsOneWidget);
      expect(find.text('bottomText2'), findsOneWidget); // Converted wind speed
      expect(find.byType(Image), findsOneWidget);
    });
  });
}
