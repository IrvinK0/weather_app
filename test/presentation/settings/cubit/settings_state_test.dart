import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/presentation/settings/cubit/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingsState', () {
    test('supports value equality', () {
      final settings1 = Settings(unit: Unit.metric);
      final settings2 = Settings(unit: Unit.metric);

      final state1 = SettingsState(settings: settings1);
      final state2 = SettingsState(settings: settings2);

      expect(state1, equals(state2));
    });

    test('_isUnitMeasurementOn returns true when unit is imperial', () {
      final settings = Settings(unit: Unit.imperial);
      final state = SettingsState(settings: settings);

      expect(state.unitSwitchValues, equals([true]));
    });

    test('_isUnitMeasurementOn returns false when unit is metric', () {
      final settings = Settings(unit: Unit.metric);
      final state = SettingsState(settings: settings);

      expect(state.unitSwitchValues, equals([false]));
    });

    test('copyWith creates a new instance with updated settings', () {
      final initialSettings = Settings(unit: Unit.metric);
      final updatedSettings = Settings(unit: Unit.imperial);

      final state = SettingsState(settings: initialSettings);
      final updatedState = state.copyWith(settings: updatedSettings);

      expect(updatedState.settings.unit, equals(Unit.imperial));
      expect(state.settings.unit, equals(Unit.metric)); // Ensure immutability
    });

    test('props contains only the settings object', () {
      final settings = Settings(unit: Unit.metric);
      final state = SettingsState(settings: settings);

      expect(state.props, equals([settings]));
    });
  });
}
