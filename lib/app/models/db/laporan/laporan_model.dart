import 'package:eport/app/models/db/base/base_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laporan_model.g.dart';

@JsonSerializable()
class LaporanModel extends BaseModel implements ModelFactory {
  final String type;
  final bool progress;

  final DateTime date;
  Object? data;

  LaporanModel({
    required super.id,
    required this.type,
    required this.progress,
    required this.date,
    this.data,
    required super.createdAt,
    required super.updatedAt,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LaporanModelToJson(this);
}
