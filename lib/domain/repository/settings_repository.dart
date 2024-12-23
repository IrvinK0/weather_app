import 'package:rxdart/subjects.dart';
import 'package:storage/storage.dart';

import '../model/models.dart';

/// A repository class that manages application settings.
/// Provides functionalities to retrieve and update settings
/// with the help of a storage client.
class SettingsRepository {
  /// Creates an instance of [SettingsRepository] with the given [StorageClient].
  SettingsRepository({required StorageClient storage}) : _storage = storage;

  /// The storage client used to persist settings.
  final StorageClient _storage;

  /// The key used to store and retrieve the unit setting from the storage.
  final String _unitKey = 'unit_key';

  /// A stream controller to broadcast the current settings to listeners.
  late final _streamController = BehaviorSubject<Settings>.seeded(settings);

  /// Returns a broadcast stream of [Settings].
  /// This allows other parts of the app to listen to changes in settings.
  Stream<Settings> getSettings() => _streamController.asBroadcastStream();

  /// Retrieves the current [Settings] from storage.
  /// Defaults to [Unit.metric] if no value is stored.
  Settings get settings {
    final isUnitImperial = _storage.get<bool>(_unitKey) ?? false;
    return Settings(unit: isUnitImperial ? Unit.imperial : Unit.metric);
  }

  /// Updates the unit setting and notifies listeners through the stream.
  /// 
  /// - [newValue]: The new settings to be saved and emitted.
  void updateUnitSettings(Settings newValue) {
    // Save the new unit setting to storage.
    _storage.save(newValue.unit == Unit.imperial, _unitKey);

    // Emit the new settings to all stream listeners.
    _streamController.add(newValue);
  }

  /// Disposes the stream controller when the repository is no longer needed.
  void dispose() {
    _streamController.close();
  }
}
