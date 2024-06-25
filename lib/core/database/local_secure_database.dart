import 'package:hive/hive.dart';

class LocalSecureDatabase {
  LocalSecureDatabase._();
  static LocalSecureDatabase instance = LocalSecureDatabase._();

  static var secureBox = Hive.box('local_secure_database');

  /// Write id token.
  static Future<void> setUserId(dynamic id) async {
    await secureBox.put('idToken', id);
  }

  /// Read id token.
  static dynamic getUserId() {
    return secureBox.get('idToken');
  }

  /// Delete id token.
  static Future<void> deleteUserId() async {
    await secureBox.delete('idToken');
  }

  static Future<bool> isUserLoggedIn() async {
    // Retrieving the user UID from the local database.
    final uid = await getUserId();
    // Checking if the user is logged in by verifying the presence of the user UID.
    return uid != null;
  }
}
