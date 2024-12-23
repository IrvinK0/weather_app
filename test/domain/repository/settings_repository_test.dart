import 'package:flaconi_weather/domain/model/models.dart';
import 'package:flaconi_weather/domain/repository/settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:storage/storage.dart';

class MockStorageClient extends Mock implements StorageClient {}

void main() {
  group('SettingsRepository', () {
    late MockStorageClient mockStorageClient;
    late SettingsRepository repository;
    final String key = 'unit_key';

    setUp(() {
      mockStorageClient = MockStorageClient();
      repository = SettingsRepository(storage: mockStorageClient);
    });

    test('settings should return default metric unit when storage has no value',
        () {
      when(() => mockStorageClient.get<bool>(key)).thenReturn(false);

      final settings = repository.settings;

      expect(settings.unit, Unit.metric);
      verify(() => mockStorageClient.get<bool>(key)).called(1);
    });

    test('settings should return imperial unit when storage has true value',
        () {
      when(() => mockStorageClient.get<bool>(key)).thenReturn(true);

      final settings = repository.settings;

      expect(settings.unit, Unit.imperial);
      verify(() => mockStorageClient.get<bool>(key)).called(1);
    });

    test('getSettings should emit the current settings', () async {
      when(() => mockStorageClient.get(key)).thenReturn(false);

      final stream = repository.getSettings();
      final settings = await stream.first;

      expect(settings.unit, Unit.metric);
    });

    test('updateUnitSettings should save to storage and emit updated settings',
        () async {
      when(() => mockStorageClient.save<bool>(any(), key)).thenAnswer((_) async {});
      when(() => mockStorageClient.get<bool>(key)).thenReturn(false);

      final newSettings = Settings(unit: Unit.imperial);
      repository.updateUnitSettings(newSettings);

      verify(() => mockStorageClient.save<bool>(true, key)).called(1);

      final stream = repository.getSettings();
      final emittedSettings = await stream.first;

      expect(emittedSettings.unit, Unit.imperial);
    });

    test('getSettings should emit updates after settings are changed',
        () async {
      when(() => mockStorageClient.save<bool>(any(), key)).thenAnswer((_) async {});
      when(() => mockStorageClient.get<bool>(key)).thenReturn(false);

      final stream = repository.getSettings();

      repository.updateUnitSettings(Settings(unit: Unit.imperial));

      await expectLater(
        stream,
        emitsInOrder([
          Settings(unit: Unit.imperial), // Updated state
        ]),
      );
    });
  });
}
