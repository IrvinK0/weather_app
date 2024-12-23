import 'package:flaconi_weather/presentation/weather_forecast/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../pump_app.dart';

void main() {
  final List<WeatherItemData> items = [
    WeatherItemData(topText: 'top', icon: 'icon', bottomText: 'b'),
    WeatherItemData(topText: 'top1', icon: 'icon1', bottomText: 'b1'),
  ];

  group('ForecastList Widget', () {
    testWidgets('renders all weather items', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpApp(
            ForecastList(
              items: items,
              selectedIndex: 1,
              onTap: (_) {},
            ),
          ));

      // Assert
      expect(find.text('top'), findsOneWidget);
      expect(find.text('top1'), findsOneWidget);
    });

    testWidgets('highlights the selected weather item', (tester) async {
      await mockNetworkImagesFor(() => tester.pumpWidget(MaterialApp(
            theme: ThemeData(primaryColor: Colors.blue),
            home: ForecastList(
              items: items,
              selectedIndex: 1,
              onTap: (_) {},
            ),
          )));

      final weatherItems =
          tester.widgetList<WeatherItem>(find.byType(WeatherItem));
      final selectedWeatherItem = weatherItems.elementAt(1);
      expect((selectedWeatherItem).isSelected, true);
    });

    testWidgets('triggers onTap callback when an item is tapped',
        (tester) async {
      int tappedIndex = -1;

      await mockNetworkImagesFor(() => tester.pumpApp(
            ForecastList(
              items: items,
              selectedIndex: 1,
              onTap: (index) {
                tappedIndex = index;
              },
            ),
          ));

      // Tap the second item
      await tester.tap(find.text('top'));
      await tester.pump();

      expect(tappedIndex, 0);
    });
  });
}
