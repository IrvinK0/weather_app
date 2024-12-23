import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/src/shared_preferences_storage_client.dart';

// Create a Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('SharedPreferencesStorageClient', () {
    late MockSharedPreferences mockPreferences;
    late SharedPreferencesStorageClient storageClient;

    setUp(() async {
      mockPreferences = MockSharedPreferences();
      storageClient =
          await SharedPreferencesStorageClient.createWithSharedPreferences(
        preferences: mockPreferences,
      );
    });

    test('save should save a boolean value', () async {
      when(() => mockPreferences.setBool('testKey', true))
          .thenAnswer((_) async => true);

      await storageClient.save(true, 'testKey');

      verify(() => mockPreferences.setBool('testKey', true)).called(1);
    });

    test('get should return a saved boolean value', () {
      when(() => mockPreferences.getBool('testKey')).thenReturn(true);

      final result = storageClient.get<bool>('testKey');

      expect(result, true);
      verify(() => mockPreferences.getBool('testKey')).called(1);
    });

    test('get should return false for a non-existent key', () {
      when(() => mockPreferences.getBool('nonExistentKey')).thenReturn(null);

      final result = storageClient.get<bool>('nonExistentKey');

      expect(result, null);
      verify(() => mockPreferences.getBool('nonExistentKey')).called(1);
    });

    test('clear should clear all stored preferences', () async {
      when(() => mockPreferences.clear()).thenAnswer((_) async => true);

      await storageClient.clear();

      verify(() => mockPreferences.clear()).called(1);
    });
  });
}
