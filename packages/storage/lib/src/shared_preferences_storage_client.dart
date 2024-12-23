import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage.dart';

/// A concrete implementation of [StorageClient] that uses
/// `SharedPreferences` for persistent key-value storage.
final class SharedPreferencesStorageClient extends StorageClient {
  /// Private constructor to prevent direct instantiation.
  SharedPreferencesStorageClient._();

  /// Factory method to create a [SharedPreferencesStorageClient] instance
  /// with a specified [prefix].
  ///
  /// - Parameters:
  ///   - [prefix]: A string prefix used to namespace the shared preferences keys.
  /// - Returns: A fully initialized instance of [SharedPreferencesStorageClient].
  static Future<SharedPreferencesStorageClient> create({
    required String prefix,
  }) async {
    final client = SharedPreferencesStorageClient._();
    await client._initializeWithPrefix(prefix);
    return client;
  }

  /// Factory method to create a [SharedPreferencesStorageClient] instance
  /// using a provided [SharedPreferences] instance.
  ///
  /// - Parameters:
  ///   - [preferences]: An existing `SharedPreferences` instance to be used.
  /// - Returns: A fully initialized instance of [SharedPreferencesStorageClient].
  static Future<SharedPreferencesStorageClient> createWithSharedPreferences({
    required SharedPreferences preferences,
  }) async {
    final client = SharedPreferencesStorageClient._();
    client._sharedPreferences = preferences;
    return client;
  }

  /// Initializes the [SharedPreferencesStorageClient] instance
  /// with the specified [prefix].
  ///
  /// - Parameters:
  ///   - [prefix]: A string prefix used for namespacing shared preference keys.
  Future<void> _initializeWithPrefix(String prefix) async {
    SharedPreferences.setPrefix(prefix);
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// The underlying `SharedPreferences` instance used for storage.
  late final SharedPreferences _sharedPreferences;

  /// Saves a value of type [T] with the given [key].
  ///
  /// - Parameters:
  ///   - [value]: The value to be saved.
  ///   - [key]: The unique key associated with the value.
  /// - Returns: A [Future] that completes when the value is saved.
  @override
  Future<void> save<T>(T value, String key) async {
    if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else {
      throw UnsupportedError('Unsupported value type');
    }
  }

  /// Retrieves a value of type [T] associated with the given [key].
  ///
  /// - Parameters:
  ///   - [key]: The unique key used to retrieve the value.
  /// - Returns: The value stored with the given key, or `null` if no value is found.
  @override
  T? get<T>(String key) {
    if (T == bool) {
      return _sharedPreferences.getBool(key) as T?;
    } else if (T == String) {
      return _sharedPreferences.getString(key) as T?;
    } else if (T == int) {
      return _sharedPreferences.getInt(key) as T?;
    } else if (T == double) {
      return _sharedPreferences.getDouble(key) as T?;
    } else {
      return null;
    }
  }

  /// Clears all stored preferences.
  ///
  /// - Returns: A [Future] that resolves when the operation is completed.
  @override
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
