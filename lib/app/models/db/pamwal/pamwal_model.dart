import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pamwal_model.g.dart';

@JsonSerializable()
class PamwalModel extends LaporanBase implements ModelFactory {
  final String? kejadian;
  final String? tindakan;

  PamwalModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.personils,
    this.kejadian,
    this.tindakan,
  });

  factory PamwalModel.fromJson(Map<String, dynamic> json) =>
      _$PamwalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PamwalModelToJson(this);
}
