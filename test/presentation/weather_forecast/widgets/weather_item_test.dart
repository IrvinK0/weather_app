import 'dart:io';

import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../pump_app.dart';

class MockHttpClient extends Mock implements HttpClient {}

class FakeUri extends Fake implements Uri {}

void main() {
  final weather =
      WeatherItemData(topText: 'top', icon: 'icon', bottomText: 'b');

  group('WeatherItem Widget', () {
    testWidgets('renders weather data correctly', (tester) async {
      const isSelected = false;
      await mockNetworkImagesFor(() =>
          tester.pumpApp(WeatherItem(item: weather, isSelected: isSelected)));

      expect(find.text('top'), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);
      expect(find.text('b'), findsOneWidget);
    });

    testWidgets('applies correct color when selected', (tester) async {
      const isSelected = true;

      await mockNetworkImagesFor(() => tester.pumpApp(MaterialApp(
            home: WeatherItem(item: weather, isSelected: isSelected),
          )));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNotNull);
      expect(decoration.boxShadow, isNotEmpty);
    });

    testWidgets('applies correct color when not selected', (tester) async {
      const isSelected = false;

      await mockNetworkImagesFor(() => tester.pumpApp(MaterialApp(
            home: WeatherItem(item: weather, isSelected: isSelected),
          )));

      final container = tester.widget<Container>(find.byType(Container));
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.border, isNull);
      expect(decoration.boxShadow, isEmpty);
    });
  });
}
