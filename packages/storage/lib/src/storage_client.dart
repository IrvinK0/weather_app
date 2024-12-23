/// An abstract class that defines the structure for a storage client.
/// This can be implemented to handle data caching for various key-value pairs.
abstract class StorageClient {
  /// Saves a value of type [T] associated with the provided [key].
  ///
  /// - Parameters:
  ///   - [value]: The value to be saved.
  ///   - [key]: A unique identifier for storing the value.
  /// - Type [T] can be any data type.
  Future<void> save<T>(T value, String key);

  /// Retrieves the value of type [T] associated with the given [key].
  ///
  /// - Parameter [key]: The unique identifier for the value.
  /// - Returns: The value stored with the given key, or `null` if no value is found.
  T? get<T>(String key);

  /// Clears all cached data.
  ///
  /// - Returns: A [Future] that resolves when the operation is completed.
  Future<void> clear();
}
