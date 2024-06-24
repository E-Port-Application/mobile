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

  List<String> personils;
  List<String>? komando;
  List<String>? anggota;

  LaporanBase({
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.id,
    required this.tanggal,
    required this.personils,
    this.komando,
    this.anggota,
    this.image,
  });
}
