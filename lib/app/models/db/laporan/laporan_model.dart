import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laporan_model.g.dart';

@JsonSerializable()
class LaporanModel implements ModelFactory {
  final String id;
  final String type;
  final bool progress;

  final DateTime date;
  Object? data;

  LaporanModel({
    required this.id,
    required this.type,
    required this.progress,
    required this.date,
    this.data,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanModelFromJson(json);
  Map<String, dynamic> toJson() => _$LaporanModelToJson(this);
}
