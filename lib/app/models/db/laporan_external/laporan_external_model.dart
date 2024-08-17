import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eport/app/models/db/base/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:eport/services/api/sources/model_factory.dart';

part 'laporan_external_model.g.dart';

@JsonSerializable()
class LaporanExternalModel extends BaseModel implements ModelFactory {
  final String location;
  final DateTime tanggal;
  final String nama;
  final String nik;
  final String keluhan;
  final String keterangan;
  final String image;
  final int status;
  final String uid;

  LaporanExternalModel({
    required this.image,
    required this.keluhan,
    required this.keterangan,
    required this.nama,
    required this.nik,
    required this.tanggal,
    required this.status,
    required this.uid,
    required this.location,
    required super.createdAt,
    required super.id,
    required super.updatedAt,
  });

  factory LaporanExternalModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanExternalModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LaporanExternalModelToJson(this);
}
