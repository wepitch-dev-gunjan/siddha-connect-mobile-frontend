

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


final secureStoargeProvider =
  Provider.autoDispose<SecureDatabase>((ref) => SecureDatabase());



class SecureDatabase {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  Future writeData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future readData(String key) async {
    String value = await storage.read(key: key) ?? '';
    return value;
  }

  Future deleteData(String key) async {
    await storage.delete(key: key);
  }

  Future clearData() async {
    await storage.deleteAll();
  }
}





