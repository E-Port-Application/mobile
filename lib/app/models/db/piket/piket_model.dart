import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'piket_model.g.dart';

@JsonSerializable()
class PiketModel extends LaporanBase implements ModelFactory {
  final String? shift;
  final String? lokasi;
  final String? tindakan;
  final String? kejadian;

  PiketModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.location,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    super.personils,
    this.shift,
    this.lokasi,
    this.tindakan,
    this.kejadian,
  });

  factory PiketModel.fromJson(Map<String, dynamic> json) =>
      _$PiketModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PiketModelToJson(this);
}
