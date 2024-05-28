import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'menu_model.g.dart';

@JsonSerializable()
class MenuModel implements ModelFactory {
  final String label;
  final String path;

  @JsonKey(name: "icon-inactive")
  final String iconInactive;

  @JsonKey(name: "icon-active")
  final String iconActive;
  bool? focus;

  MenuModel({
    required this.iconActive,
    required this.iconInactive,
    required this.label,
    required this.path,
    this.focus,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) =>
      _$MenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$MenuModelToJson(this);
}
