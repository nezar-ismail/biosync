import 'package:hive_flutter/hive_flutter.dart';
import 'local_doctor_model.dart';

class LocalDoctorModelService {
  static final _box = Hive.box<LocalDoctorModel>('localDoctorModelBox');
  // static late final LocalDoctorModelService instance;
  // Get all doctors
  static List<LocalDoctorModel> getDoctors() {
    return _box.values.toList();
  }

  // Add or Update a doctor
  static Future<void> addOrUpdateDoctor(LocalDoctorModel doctor) async {
    await _box.put(doctor.id, doctor); // Using ID as key for uniqueness
  }

  // Remove a doctor
  static Future<void> removeDoctor(int id) async {
    await _box.delete(id);
  }

  // Clear all doctors
  static Future<void> clearDoctors() async {
    await _box.clear();
  }
}
