import 'package:eport/app/models/db/base/base_model.dart';
import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LaporanBase extends BaseModel {
  DateTime tanggal;
  @JsonKey(name: "waktu-mulai")
  final DateTime waktuMulai;

  @JsonKey(name: "waktu-selesai")
  final DateTime waktuSelesai;

  String? image;

  List<PersonilModel>? personils;
  String? keterangan;
  String location;

  LaporanBase({
    required this.waktuMulai,
    required this.waktuSelesai,
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.tanggal,
    required this.location,
    this.personils,
    this.keterangan,
    this.image,
  });
}
