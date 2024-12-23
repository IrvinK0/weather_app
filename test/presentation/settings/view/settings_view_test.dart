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
  group('SettingsView', () {
    late MockSettingsCubit cubit;

    setUp(() {
      cubit = MockSettingsCubit();
    });

    testWidgets('displays the correct title, subtitle, and switch state',
        (tester) async {
      when(() => cubit.state)
          .thenReturn(SettingsState(settings: Settings(unit: Unit.metric)));

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SettingsCubit>.value(
            value: cubit,
            child: const SettingsView(),
          ),
        ),
      );

      expect(find.text('Units of measurement'), findsOneWidget);
      expect(find.text('Use imperial units.'), findsOneWidget);
      expect(find.byType(Switch), findsOneWidget);
    });

    testWidgets('toggles the unit when switch is tapped', (tester) async {
      final mockState = SettingsState(
        settings: Settings(unit: Unit.metric),
      );
      when(() => cubit.state).thenReturn(mockState);
      when(() => cubit.toggleUnit(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SettingsCubit>.value(
            value: cubit,
            child: const SettingsView(),
          ),
        ),
      );

      final switchFinder = find.byType(Switch);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      verify(() => cubit.toggleUnit(true)).called(1);
    });
  });
}
