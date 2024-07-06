import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'kransos_model.g.dart';

@JsonSerializable()
class KransosModel extends LaporanBase implements ModelFactory {
  final String? jenis;

  @JsonKey(name: "deskripsi-pelanggaran")
  final String? deskripsi;

  @JsonKey(name: "tindakan-pelanggaran")
  final String? tindakan;

  @JsonKey(name: "jumlah-pelanggar")
  final int? jumlah;

  KransosModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.location,
    super.personils,
    super.image,
    this.deskripsi,
    this.jumlah,
    this.tindakan,
    this.jenis,
  });

  factory KransosModel.fromJson(Map<String, dynamic> json) =>
      _$KransosModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KransosModelToJson(this);
}
