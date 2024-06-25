import 'package:hive/hive.dart';
part 'local_doctor_model.g.dart';

@HiveType(typeId: 0)
class LocalDoctorModel {
  @HiveField(0)
  final String? doctorEmail;
  @HiveField(1)
  final String? doctorName;
  @HiveField(2)
  final int? id;
  @HiveField(3)
  final String? phone;
  @HiveField(4)
  final String? image;
  @HiveField(5)
  final String? gender;
  @HiveField(6)
  final String? specialization;
  @HiveField(7)
  final String? about;
  @HiveField(8)
  final List<String>? workDay;
  @HiveField(9)
  final double? averageRating;
  @HiveField(10)
  final String? experience;

  LocalDoctorModel({
    required this.experience,
    required this.image,
    required this.doctorEmail,
    required this.doctorName,
    required this.id,
    required this.phone,
    required this.gender,
    required this.specialization,
    required this.about,
    required this.workDay,
    required this.averageRating,
  });
}
