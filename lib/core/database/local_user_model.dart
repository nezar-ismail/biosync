
import 'package:hive/hive.dart';

class LocalUserModel {
  LocalUserModel._();
  static final LocalUserModel instance = LocalUserModel._();

  static final _box = Hive.box('LocalUserModel');

  // Getters
  static String getUserEmail() {
    return _box.get('userEmail', defaultValue: '');
  }

  static String getUserName() {
    return _box.get('userName', defaultValue: '');
  }

  static int getUserId() {
    return _box.get('userId', defaultValue: 0);
  }

  static String getUserPhone() {
    return _box.get('userPhone', defaultValue: '');
  }

  static String getSpecialization() {
    return _box.get('specialization', defaultValue: '');
  }

  static String getUserImage() {
    return _box.get('userImage',
        defaultValue: '/Static/DefaultImage/default.png');
  }

  static String getUserGender() {
    return _box.get('userGender', defaultValue: '');
  }

  static List<String>? getWorkday() {
    return _box.get('workday', defaultValue: []);
  }

  static String? getExperience() {
    return _box.get('experience', defaultValue: '');
  }

  static String getAbout() {
    return _box.get('about', defaultValue: '');
  }

  static double getRating() {
    return _box.get('rating', defaultValue: 0.0);
  }

  static String getUserType() {
    return _box.get('sender_type', defaultValue: '');
  }

  // Setters
  static Future<void> setUserEmail(String val) async {
    await _box.put('userEmail', val);
  }

  static Future<void> setUserName(String val) async {
    await _box.put('userName', val);
  }

  static Future<void> setUserId(int val) async {
    await _box.put('userId', val);
  }

  static Future<void> setUserPhone(String val) async {
    await _box.put('userPhone', val);
  }

  static Future<void> setUserImage(String val) async {
    await _box.put('userImage', val);
  }

  static Future<void> setUserGender(String val) async {
    await _box.put('userGender', val);
  }

  static Future<void> setWorkday(List<String> val) async {
    await _box.put('workday', val);
  }

  static Future<void> setExperience(String? val) async {
    await _box.put('experience', val);
  }

  static Future<void> setAbout(String val) async {
    await _box.put('about', val);
  }

  static Future<void> setSpecialization(String val) async {
    await _box.put('specialization', val);
  }

  static Future<void> setRating(double val) async {
    await _box.put('rating', val);
  }

  static Future<void> setUserType(String val) async {
    await _box.put("sender_type", val);
  }

  static Future<void> deleteUser() async {
    await _box.deleteAll([
      'userEmail',
      'userName',
      'userId',
      'userPhone',
      'userImage',
      'userGender',
      'workday',
      'experience',
      'about',
      'specialization',
      'rating'
    ]);
  }

  static Future<void> deleteUserImage() async {
    await _box.delete('userImage');
  }
}
