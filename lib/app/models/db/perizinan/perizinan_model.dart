import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app/models/db/laporan/laporan_base.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'perizinan_model.g.dart';

@JsonSerializable()
class PerizinanModel extends LaporanBase implements ModelFactory {
  final String? nama;
  final String? jenis;
  final String? pelanggaran;
  final String? tindakan;
  final int? jumlah;

  PerizinanModel({
    required super.tanggal,
    required super.waktuMulai,
    required super.waktuSelesai,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.location,
    super.personils,
    this.jenis,
    this.nama,
    this.pelanggaran,
    this.tindakan,
    this.jumlah,
  });

  factory PerizinanModel.fromJson(Map<String, dynamic> json) =>
      _$PerizinanModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PerizinanModelToJson(this);
}
