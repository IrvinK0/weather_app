import 'package:bloc_test/bloc_test.dart';
import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/presentation/settings/cubit/settings_cubit.dart';
import 'package:flaconi_weather/presentation/settings/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsCubit extends MockCubit<SettingsState>
    implements SettingsCubit {}

void main() {
  group('WeatherForecastPage', () {
    late MockSettingsCubit cubit;

    setUp(() {
      cubit = MockSettingsCubit();

      when(() => cubit.state).thenReturn(
        SettingsState(settings: Settings(unit: Unit.metric)),
      );
    });

    testWidgets('renders SettingsView', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SettingsCubit>.value(
            value: cubit,
            child: const SettingsPage(),
          ),
        ),
      );

      expect(find.byType(SettingsView), findsOneWidget);
    });
  });
}
