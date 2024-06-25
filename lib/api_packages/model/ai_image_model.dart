// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AIModel {
  String? image;
  String? hitMap;
  String? result;
  String? reliability;
  AIModel({
    this.image,
    this.hitMap,
    this.result,
    this.reliability,
  });

  AIModel copyWith({
    String? image,
    String? hitMap,
    String? result,
    String? reliability,
  }) {
    return AIModel(
      image: image ?? this.image,
      hitMap: hitMap ?? this.hitMap,
      result: result ?? this.result,
      reliability: reliability ?? this.reliability,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'heatmap': hitMap,
      'result': result,
      'Reliability': reliability,
    };
  }

  factory AIModel.fromMap(Map<String, dynamic> map) {
    return AIModel(
      image: map['image'] != null ? map['image'] as String : null,
      hitMap: map['heatmap'] != null ? map['heatmap'] as String : null,
      result: map['result'] != null ? map['result'] as String : null,
      reliability:
          map['Reliability'] != null ? map['Reliability'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AIModel.fromJson(String source) =>
      AIModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AIModel(image: $image, heatmap: $hitMap, result: $result, Reliability: $reliability)';
  }

  @override
  bool operator ==(covariant AIModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.hitMap == hitMap &&
        other.result == result &&
        other.reliability == reliability;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        hitMap.hashCode ^
        result.hashCode ^
        reliability.hashCode;
  }
}
