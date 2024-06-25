// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatBox {
  int doctorId;
  int patientId;
  String doctorName;
  String patientName;
  String doctorImage;
  String patientImage;
  String lastMessage;
  bool isDoctorOnline;
  bool isPatientOnline;
  String? lastMessageTime;
  int roomId;
  bool isRead;
  String? senderType;
  ChatBox({
    required this.isRead,
    required this.senderType,
    required this.isDoctorOnline,
    required this.isPatientOnline,
    required this.lastMessageTime,
    required this.roomId,
    required this.doctorId,
    required this.patientId,
    required this.doctorName,
    required this.patientName,
    required this.doctorImage,
    required this.patientImage,
    required this.lastMessage,
  });

  ChatBox copyWith(
      {int? doctorId,
      int? patientId,
      String? doctorName,
      String? patientName,
      String? doctorImage,
      String? patientImage,
      String? lastMessage,
      bool? isDoctorOnline,
      bool? isPatientOnline,
      String? lastMessageTime,
      bool? isRead,
      String? senderType,
      int? roomId}) {
    return ChatBox(
      senderType: senderType ?? this.senderType,
      isRead: isRead ?? this.isRead,
      isDoctorOnline: isDoctorOnline ?? this.isDoctorOnline,
      isPatientOnline: isPatientOnline ?? this.isPatientOnline,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      roomId: roomId ?? this.roomId,
      doctorId: doctorId ?? this.doctorId,
      patientId: patientId ?? this.patientId,
      doctorName: doctorName ?? this.doctorName,
      patientName: patientName ?? this.patientName,
      doctorImage: doctorImage ?? this.doctorImage,
      patientImage: patientImage ?? this.patientImage,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender_type': senderType,
      'is_read': isRead,
      'is_doctor_online': isDoctorOnline,
      'is_patient_online': isPatientOnline,
      'created_at': lastMessageTime,
      'room_id': doctorId,
      'patient_id': patientId,
      'doctor_name': doctorName,
      'patient_name': patientName,
      'doctor_image': doctorImage,
      'patient_image': patientImage,
      'last_message': lastMessage,
    };
  }

  factory ChatBox.fromMap(Map<String, dynamic> map) {
    return ChatBox(
      senderType: map['sender_type'] as String,
      isRead: map['is_read'] as bool,
      isDoctorOnline: map['doctor_active'] as bool,
      isPatientOnline: map['patient_active'] as bool,
      lastMessageTime: map['created_at'] ?? '',
      roomId: map['room_id'] as int,
      doctorId: map['doctor_id'] as int,
      patientId: map['patient_id'] as int,
      doctorName: map['doctor_name'] as String,
      patientName: map['patient_name'] as String,
      doctorImage: map['doctor_image'] as String,
      patientImage: map['patient_image'] as String,
      lastMessage: map['last_message'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatBox.fromJson(String source) =>
      ChatBox.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Chat(doctor_id: $doctorId, patient_id: $patientId, doctor_name: $doctorName, patient_name: $patientName, doctor_image: $doctorImage, patient_image: $patientImage, last_message: $lastMessage, room_id: $roomId, is_doctor_online: $isDoctorOnline, is_patient_online: $isPatientOnline, created_at: $lastMessageTime, is_read: $isRead, sender_type: $senderType)';
  }

  @override
  bool operator ==(covariant ChatBox other) {
    if (identical(this, other)) return true;

    return other.doctorId == doctorId &&
        other.isRead == isRead &&
        other.senderType == senderType &&
        other.patientId == patientId &&
        other.doctorName == doctorName &&
        other.patientName == patientName &&
        other.doctorImage == doctorImage &&
        other.patientImage == patientImage &&
        other.roomId == roomId &&
        other.lastMessageTime == lastMessageTime &&
        other.isDoctorOnline == isDoctorOnline &&
        other.isPatientOnline == isPatientOnline &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return doctorId.hashCode ^
        isRead.hashCode ^
        senderType.hashCode ^
        patientId.hashCode ^
        doctorName.hashCode ^
        patientName.hashCode ^
        doctorImage.hashCode ^
        patientImage.hashCode ^
        isDoctorOnline.hashCode ^
        isPatientOnline.hashCode ^
        lastMessageTime.hashCode ^
        roomId.hashCode ^
        lastMessage.hashCode;
  }
}
