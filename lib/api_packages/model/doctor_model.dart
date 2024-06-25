// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, unnecessary_this
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DoctorModel {
  final String about;
  final double averageRating;
  final String doctoremail; //
  final String doctorname; //
  final String gender; //
  final int id; //
  final String image; //
  final String phone; //
  final String specialization;
  final List<String>? workday;
  final String? experience;

  DoctorModel({
    required this.about,
    required this.averageRating,
    required this.doctoremail,
    required this.doctorname,
    required this.gender,
    required this.id,
    required this.image,
    required this.phone,
    required this.specialization,
    this.workday,
    required this.experience,
  });

  DoctorModel copyWith({
    String? about,
    double? averageRating,
    String? doctoremail,
    String? doctorname,
    String? gender,
    int? id,
    String? image,
    String? phone,
    String? specialization,
    List<String>? workday,
    String? experience,
  }) {
    return DoctorModel(
      about: about ?? this.about,
      averageRating: averageRating ?? this.averageRating,
      doctoremail: doctoremail ?? this.doctoremail,
      doctorname: doctorname ?? this.doctorname,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      specialization: specialization ?? this.specialization,
      workday: workday ?? this.workday,
      experience: experience ?? this.experience,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'about': about,
      'average_rating': averageRating,
      'doctoremail': doctoremail,
      'doctorname': doctorname,
      'gender': gender,
      'id': id,
      'image': image,
      'phone': phone,
      'specialization': specialization,
      'workday': workday,
      'experience': experience,
    };
  }

  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      about: map['about'] as String,
      averageRating: map['average_rating'] as double? ?? 0.0,
      doctoremail: map['doctoremail'] as String,
      doctorname: map['doctorname'] as String,
      experience: map['experience'] as String,
      gender: map['gender'] as String,
      id: map['id'],
      image: map['image'] as String,
      phone: map['phone'] as String,
      specialization: map['specialization'] as String,
      workday: List<String>.from(map['workday'].map((item) => item.toString())),
    );
  }

  String toJson() => json.encode(toMap());

  factory DoctorModel.fromJson(String source) =>
      DoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DoctorModel(about: $about, averageRating: $averageRating, doctoremail: $doctoremail, doctorname: $doctorname, gender: $gender, id: $id, image: $image, phone: $phone, specialization: $specialization, workday: $workday, experience: $experience)';
  }

  @override
  bool operator ==(covariant DoctorModel other) {
    if (identical(this, other)) return true;

    return other.about == about &&
        other.averageRating == averageRating &&
        other.doctoremail == doctoremail &&
        other.doctorname == doctorname &&
        other.gender == gender &&
        other.id == id &&
        other.image == image &&
        other.phone == phone &&
        other.specialization == specialization &&
        listEquals(other.workday, workday) &&
        other.experience == experience;
  }

  @override
  int get hashCode {
    return about.hashCode ^
        averageRating.hashCode ^
        doctoremail.hashCode ^
        doctorname.hashCode ^
        gender.hashCode ^
        id.hashCode ^
        image.hashCode ^
        phone.hashCode ^
        specialization.hashCode ^
        workday.hashCode ^
        experience.hashCode;
  }
}
