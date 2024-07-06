// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perizinan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PerizinanModel _$PerizinanModelFromJson(Map<String, dynamic> json) =>
    PerizinanModel(
      tanggal: DateTime.parse(json['tanggal'] as String),
      waktuMulai: DateTime.parse(json['waktu-mulai'] as String),
      waktuSelesai: DateTime.parse(json['waktu-selesai'] as String),
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created-at'] as String),
      updatedAt: DateTime.parse(json['updated-at'] as String),
      location: json['location'] as String,
      personils: (json['personils'] as List<dynamic>?)
          ?.map((e) => PersonilModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      jenis: json['jenis'] as String?,
      nama: json['nama'] as String?,
      pelanggaran: json['pelanggaran'] as String?,
      tindakan: json['tindakan'] as String?,
      jumlah: json['jumlah'] as int?,
    )
      ..image = json['image'] as String?
      ..keterangan = json['keterangan'] as String?;

Map<String, dynamic> _$PerizinanModelToJson(PerizinanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt.toIso8601String(),
      'tanggal': instance.tanggal.toIso8601String(),
      'waktu-mulai': instance.waktuMulai.toIso8601String(),
      'waktu-selesai': instance.waktuSelesai.toIso8601String(),
      'image': instance.image,
      'personils': instance.personils?.map((e) => e.toJson()).toList(),
      'keterangan': instance.keterangan,
      'location': instance.location,
      'nama': instance.nama,
      'jenis': instance.jenis,
      'pelanggaran': instance.pelanggaran,
      'tindakan': instance.tindakan,
      'jumlah': instance.jumlah,
    };
