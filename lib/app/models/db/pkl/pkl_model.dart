import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pkl_model.g.dart';

@JsonSerializable()
class PklModel extends LaporanBase implements ModelFactory {
  String? jenis;
  String? pelanggaran;
  String? tindakan;

  @JsonKey(name: "jumlah-pelanggar")
  int? jumlahPelanggar;

  @JsonKey(name: "nama-pelanggar")
  String? namaPelanggar;

  @JsonKey(name: "nik-pelanggar")
  String? nikPelanggar;

  @JsonKey(name: "jenis-kelamin")
  String? jenisKelamin;

  @JsonKey(name: "alamat-pelanggar")
  String? alamatPelanggar;

  @JsonKey(name: "created-at")
  DateTime? createdAt;

  @JsonKey(name: "updated-at")
  DateTime? updatedAt;

  PklModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.id,
    required this.createdAt,
    required this.updatedAt,
    super.personils,
    super.image,
    super.keterangan,
    this.jenis,
    this.pelanggaran,
    this.tindakan,
    this.jumlahPelanggar,
    this.alamatPelanggar,
    this.jenisKelamin,
    this.namaPelanggar,
    this.nikPelanggar,
  });

  factory PklModel.fromJson(Map<String, dynamic> json) =>
      _$PklModelFromJson(json);

  Map<String, dynamic> toJson() => _$PklModelToJson(this);
}
