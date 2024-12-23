import 'package:storage/src/shared_preferences_storage_client.dart';
import 'package:storage/src/storage_client.dart';

export 'src/storage_client.dart';

/// Factory method to create an instance of [StorageClient].
///
/// - [storageId]: A unique identifier used as a prefix for the stored keys.
///
/// Returns a [StorageClient] instance initialized with the given prefix.
Future<StorageClient> createStorageClient({required String storageId}) =>
   SharedPreferencesStorageClient.create(prefix: storageId);
