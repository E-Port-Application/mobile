import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pkl_model.g.dart';

@JsonSerializable()
class PklModel implements ModelFactory {
  DateTime tanggal;

  @JsonKey(name: "waktu-mulai")
  DateTime waktuMulai;

  @JsonKey(name: "waktu-selesai")
  DateTime waktuSelesai;

  String? jenis;
  String? pelanggaran;
  String? tindakan;

  @JsonKey(name: "jumlah-pelanggar")
  int? jumlahPelanggar;

  List<String>? personils;
  String? keterangan;
  String? image;

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
    required this.tanggal,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.createdAt,
    required this.updatedAt,
    this.jenis,
    this.pelanggaran,
    this.tindakan,
    this.jumlahPelanggar,
    this.personils,
    this.keterangan,
    this.image,
    this.alamatPelanggar,
    this.jenisKelamin,
    this.namaPelanggar,
    this.nikPelanggar,
  });

  factory PklModel.fromJson(Map<String, dynamic> json) =>
      _$PklModelFromJson(json);
  Map<String, dynamic> toJson() => _$PklModelToJson(this);
}
