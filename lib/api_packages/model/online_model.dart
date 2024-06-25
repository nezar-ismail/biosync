// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OnlineUsers {
  int? userId;
  String? userType;
  String? userImage;
  OnlineUsers({
    this.userId,
    this.userType,
    this.userImage,
  });

  OnlineUsers copyWith({
    int? userId,
    String? userType,
    String? userImage,
  }) {
    return OnlineUsers(
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      userImage: userImage ?? this.userImage,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sender_id': userId,
      'sender_type': userType,
      'image': userImage,
    };
  }

  factory OnlineUsers.fromMap(Map<String, dynamic> map) {
    return OnlineUsers(
      userId: map['sender_id'] != null ? map['sender_id'] as int : null,
      userType:
          map['sender_type'] != null ? map['sender_type'] as String : null,
      userImage: map['image'] != null ? map['image'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OnlineUsers.fromJson(String source) =>
      OnlineUsers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OnlineUsers(sender_id: $userId,sender_type: $userType, image: $userImage)';

  @override
  bool operator ==(covariant OnlineUsers other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.userType == userType &&
        other.userImage == userImage;
  }

  @override
  int get hashCode => userId.hashCode ^ userType.hashCode ^ userImage.hashCode;
}
