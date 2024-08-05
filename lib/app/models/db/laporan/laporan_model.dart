import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? location;
  bool? isExternal = false;

  LaporanModel({
    required super.id,
    required this.type,
    required this.progress,
    required this.date,
    required super.createdAt,
    required super.updatedAt,
    this.isExternal = false,
    this.data,
    this.location,
  });

  factory LaporanModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LaporanModelToJson(this);
}
