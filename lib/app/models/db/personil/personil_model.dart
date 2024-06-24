import 'package:json_annotation/json_annotation.dart';
part 'personil_model.g.dart';

@JsonSerializable()
class PersonilModel {
  final String id;
  final String name;
  final bool komando;
  final String? regu;

  const PersonilModel({
    required this.id,
    required this.komando,
    required this.name,
    this.regu,
  });

  factory PersonilModel.fromJson(Map<String, dynamic> json) =>
      _$PersonilModelFromJson(json);
  Map<String, dynamic> toJson() => _$PersonilModelToJson(this);
}

class PersonilState {
  final PersonilModel personil;
  bool isSelected;

  PersonilState({
    required this.personil,
    this.isSelected = false,
  });
}
