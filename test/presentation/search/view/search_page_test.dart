import 'package:flaconi_weather/presentation/search/view/view.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../pump_app.dart';

void main() {
  group('SearchPage', () {
    testWidgets('renders SearchView', (WidgetTester tester) async {
      await tester.pumpApp(SearchPage());

      expect(find.byType(SearchView), findsOneWidget);
    });
  });
}
