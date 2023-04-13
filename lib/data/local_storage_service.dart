import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class LocalStorageService {
  const LocalStorageService._(this.storage, this.iosOptions);

  static const userIdKey = 'User_Id_Key';

  final FlutterSecureStorage storage;
  final IOSOptions iosOptions;

  static const instance = LocalStorageService._(
    FlutterSecureStorage(),
    IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  Future<String> _getUserId() async {
    final value = await storage.read(key: userIdKey);
    return value ?? '';
  }

  Future<String> _setUserId() async {
    final id = const Uuid().v4();
    await storage.write(key: userIdKey, value: id, iOptions: iosOptions);
    return id;
  }

  Future<String> checkUserId() async {
    final userId = await _getUserId();
    if (userId.isNotEmpty) return userId;
    return await _setUserId();
  }
}
