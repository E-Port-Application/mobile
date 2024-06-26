import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'reklame_model.g.dart';

@JsonSerializable()
class ReklameModel extends LaporanBase implements ModelFactory {
  String? nama;
  String? jenis;
  String? pelanggaran;
  int? jumlah;
  String? tindakan;

  @JsonKey(name: "created-at")
  DateTime? createdAt;

  @JsonKey(name: "updated-at")
  DateTime? updatedAt;

  ReklameModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.id,
    super.personils,
    super.image,
    super.keterangan,
    this.nama,
    this.jenis,
    this.pelanggaran,
    this.jumlah,
    this.tindakan,
    this.createdAt,
    this.updatedAt,
  });

  factory ReklameModel.fromJson(Map<String, dynamic> json) =>
      _$ReklameModelFromJson(json);
  Map<String, dynamic> toJson() => _$ReklameModelToJson(this);
}
