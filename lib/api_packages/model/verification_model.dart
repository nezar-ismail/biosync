// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class VerificationModel {
  final String verificationCode;
  VerificationModel({
    required this.verificationCode,
  });

  VerificationModel copyWith({
    String? verificationCode,
  }) {
    return VerificationModel(
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'verification_code': verificationCode,
    };
  }

  factory VerificationModel.fromMap(Map<String, dynamic> map) {
    return VerificationModel(
      verificationCode: map['verification_code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VerificationModel.fromJson(String source) =>
      VerificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'VerificationModel(verification_code: $verificationCode)';

  @override
  bool operator ==(covariant VerificationModel other) {
    if (identical(this, other)) return true;

    return other.verificationCode == verificationCode;
  }

  @override
  int get hashCode => verificationCode.hashCode;
}
