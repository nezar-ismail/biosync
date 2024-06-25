import 'package:hive/hive.dart';

class LocalDataBase {
  LocalDataBase._();
  static LocalDataBase instance = LocalDataBase._();

  static final _box = Hive.box('local_database');
// await _box = Hive.openBox('local_database');
  static Future<void> setIsFirstTime(bool value) async {
    await _box.put('isFirstTime', value);
  }

  static bool getIsFirstTime() {
    final check = _box.get('isFirstTime') ?? true;
    return check;
  }

  static String getIPAddress() {
    final check = _box.get('ipAddress') ?? 'http://192.168.213.253:5000';
    return check;
  }

  static Future<void> setIPAddress(String val) async {
    await _box.put("ipAddress", val);
  }
}
