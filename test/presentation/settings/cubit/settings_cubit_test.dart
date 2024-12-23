import 'package:bloc_test/bloc_test.dart';
import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/domain/repository/settings_repository.dart';
import 'package:flaconi_weather/presentation/settings/cubit/settings_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSettingsRepository extends Mock implements SettingsRepository {}

void main() {
  group('SettingsCubit', () {
    late MockSettingsRepository mockSettingsRepository;

    setUp(() {
      mockSettingsRepository = MockSettingsRepository();
      registerFallbackValue(Settings(unit: Unit.metric));
    });

    test('initial state is derived from the repository settings', () {
      final initialSettings = Settings(unit: Unit.metric);
      when(() => mockSettingsRepository.settings).thenReturn(initialSettings);

      final cubit = SettingsCubit(mockSettingsRepository);

      expect(cubit.state, SettingsState(settings: initialSettings));
    });

    blocTest<SettingsCubit, SettingsState>(
      'emits new state when toggleUnit is called with true (imperial)',
      setUp: () {
        when(() => mockSettingsRepository.updateUnitSettings(any()))
            .thenAnswer((_) async {});
      },
      build: () {
        when(() => mockSettingsRepository.settings)
            .thenReturn(Settings(unit: Unit.metric));
        return SettingsCubit(mockSettingsRepository);
      },
      act: (cubit) => cubit.toggleUnit(true),
      verify: (_) {
        verify(() => mockSettingsRepository
            .updateUnitSettings(Settings(unit: Unit.imperial))).called(1);
      },
      expect: () => [
        SettingsState(settings: Settings(unit: Unit.imperial)),
      ],
    );

    blocTest<SettingsCubit, SettingsState>(
      'emits new state when toggleUnit is called with false (metric)',
      setUp: () {
        when(() => mockSettingsRepository.updateUnitSettings(any()))
            .thenAnswer((_) async {});
      },
      build: () {
        when(() => mockSettingsRepository.settings)
            .thenReturn(Settings(unit: Unit.imperial));
        return SettingsCubit(mockSettingsRepository);
      },
      act: (cubit) => cubit.toggleUnit(false),
      verify: (_) {
        verify(() => mockSettingsRepository
            .updateUnitSettings(Settings(unit: Unit.metric))).called(1);
      },
      expect: () => [
        SettingsState(settings: Settings(unit: Unit.metric)),
      ],
    );
  });
}
