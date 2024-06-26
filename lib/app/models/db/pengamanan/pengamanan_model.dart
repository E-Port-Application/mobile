import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pengamanan_model.g.dart';

@JsonSerializable()
class PengamananModel extends LaporanBase implements ModelFactory {
  final String? kejadian;
  final String? tindakan;

  PengamananModel({
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

  factory PengamananModel.fromJson(Map<String, dynamic> json) =>
      _$PengamananModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PengamananModelToJson(this);
}
