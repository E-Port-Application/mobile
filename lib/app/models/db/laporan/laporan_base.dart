import 'package:eport/app/models/db/personil/personil_model.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LaporanBase {
  final String id;

  DateTime tanggal;
  @JsonKey(name: "waktu-mulai")
  final DateTime waktuMulai;

  @JsonKey(name: "waktu-selesai")
  final DateTime waktuSelesai;

  String? image;

  List<PersonilModel>? personils;
  String? keterangan;

  LaporanBase({
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.id,
    required this.tanggal,
    this.personils,
    this.keterangan,
    this.image,
  });
}
