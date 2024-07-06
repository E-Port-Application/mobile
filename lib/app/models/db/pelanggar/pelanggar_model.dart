import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pelanggar_model.g.dart';

@JsonSerializable()
class PelanggarModel implements ModelFactory {
  final String name;
  final String nik;
  final String id;

  const PelanggarModel({
    required this.name,
    required this.nik,
    required this.id,
  });

  factory PelanggarModel.fromJson(Map<String, dynamic> json) =>
      _$PelanggarModelFromJson(json);
  Map<String, dynamic> toJson() => _$PelanggarModelToJson(this);
}
