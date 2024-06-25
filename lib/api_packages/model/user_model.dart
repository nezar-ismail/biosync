import 'dart:convert';

class PatientModel {
  final String gender;
  final int id;
  final String image;
  final String phone;
  final String useremail;
  final String username;
  PatientModel({
    required this.gender,
    required this.id,
    required this.image,
    required this.phone,
    required this.useremail,
    required this.username,
  });

  PatientModel copyWith({
    String? gender,
    String? uid,
    String? image,
    String? phone,
    String? useremail,
    String? username,
  }) {
    return PatientModel(
      gender: gender ?? this.gender,
      id: id,
      image: image ?? this.image,
      phone: phone ?? this.phone,
      useremail: useremail ?? this.useremail,
      username: username ?? this.username,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'gender': gender,
      'id': id,
      'image': image,
      'phone': phone,
      'useremail': useremail,
      'username': username,
    };
  }

  factory PatientModel.fromMap(map) {
    return PatientModel(
      gender: map['gender'],
      id: map['id'],
      image: map['image'],
      phone: map['phone'],
      useremail: map['useremail'],
      username: map['username'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PatientModel.fromJson(String source) =>
      PatientModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(gender: $gender, id: $id, image: $image, phone: $phone, useremail: $useremail, username: $username)';
  }

  @override
  bool operator ==(covariant PatientModel other) {
    if (identical(this, other)) return true;

    return other.gender == gender &&
        other.id == id &&
        other.image == image &&
        other.phone == phone &&
        other.useremail == useremail &&
        other.username == username;
  }

  @override
  int get hashCode {
    return gender.hashCode ^
        id.hashCode ^
        image.hashCode ^
        phone.hashCode ^
        useremail.hashCode ^
        username.hashCode;
  }
}
