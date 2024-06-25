// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String? sender_type;
  String? message;
  String? created_at;
  int? sender_id;
  int? receiver_id;
  int? room_id;
  bool? is_read;
  String? sender_name;
  Message({
    this.sender_name,
    this.sender_type,
    this.message,
    this.created_at,
    this.sender_id,
    this.receiver_id,
    this.room_id,
    this.is_read,
  });

  Message copyWith({
    String? sender_name,
    String? sender_type,
    String? message,
    String? created_at,
    int? sender_id,
    int? receiver_id,
    int? room_id,
    bool? is_read,
  }) {
    return Message(
      is_read: is_read ?? this.is_read,
      sender_name: sender_name ?? this.sender_name,
      sender_type: sender_type ?? this.sender_type,
      message: message ?? this.message,
      created_at: created_at ?? this.created_at,
      sender_id: sender_id ?? this.sender_id,
      receiver_id: receiver_id ?? this.receiver_id,
      room_id: room_id ?? this.room_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender_name': sender_name,
      'sender_type': sender_type,
      'message': message,
      'created_at': created_at,
      'sender_id': sender_id,
      'receiver_id': receiver_id,
      'room_id': room_id,
      'is_read': is_read
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      sender_name:
          map['sender_name'] != null ? map['sender_name'] as String : 'null',
      sender_type:
          map['sender_type'] != null ? map['sender_type'] as String : 'null',
      message: map['message'] != null ? map['message'] as String : 'null',
      created_at:
          map['created_at'] != null ? map['created_at'] as String : 'null',
      sender_id: map['sender_id'] != null ? map['sender_id'] as int : null,
      receiver_id:
          map['receiver_id'] != null ? map['receiver_id'] as int : null,
      room_id: map['room_id'] != null ? map['room_id'] as int : null,
      is_read: map['is_read'] != null ? map['is_read'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Message(sender_type: $sender_type, message: $message, createdAt: $created_at, sender_id: $sender_id, receiver_id: $receiver_id, room_id: $room_id, is_read: $is_read, sender_name: $sender_name)';
  }

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.sender_type == sender_type &&
        other.sender_name == sender_name &&
        other.message == message &&
        other.created_at == created_at &&
        other.sender_id == sender_id &&
        other.receiver_id == receiver_id &&
        other.is_read == is_read &&
        other.room_id == room_id;
  }

  @override
  int get hashCode {
    return sender_type.hashCode ^
        sender_name.hashCode ^
        message.hashCode ^
        created_at.hashCode ^
        sender_id.hashCode ^
        receiver_id.hashCode ^
        is_read.hashCode ^
        room_id.hashCode;
  }
}
