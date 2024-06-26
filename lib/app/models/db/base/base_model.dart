import 'package:json_annotation/json_annotation.dart';

part 'base_model.g.dart';

@JsonSerializable()
class BaseModel {
  final String id;

  @JsonKey(name: "created-at")
  DateTime createdAt;

  @JsonKey(name: "updated-at")
  DateTime updatedAt;

  BaseModel({
    required this.createdAt,
    required this.id,
    required this.updatedAt,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$BaseModelToJson(this);
}
