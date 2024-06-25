// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class WorkdayEditModel {
  String id;
  List<String> workday;
  WorkdayEditModel({
    required this.id,
    required this.workday,
  });

  WorkdayEditModel copyWith({
    String? id,
    List<String>? workday,
  }) {
    return WorkdayEditModel(
      id: id ?? this.id,
      workday: workday ?? this.workday,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'workday': workday,
    };
  }

  factory WorkdayEditModel.fromMap(Map<String, dynamic> map) {
    return WorkdayEditModel(
      id: map['id'] as String,
      workday: List<String>.from(
        (map['workday'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory WorkdayEditModel.fromJson(String source) =>
      WorkdayEditModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'WorkdayEditModel(id: $id, workday: $workday)';

  @override
  bool operator ==(covariant WorkdayEditModel other) {
    if (identical(this, other)) return true;

    return other.id == id && listEquals(other.workday, workday);
  }

  @override
  int get hashCode => id.hashCode ^ workday.hashCode;
}
