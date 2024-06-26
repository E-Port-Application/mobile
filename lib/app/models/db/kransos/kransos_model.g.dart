// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kransos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KransosModel _$KransosModelFromJson(Map<String, dynamic> json) => KransosModel(
      tanggal: DateTime.parse(json['tanggal'] as String),
      waktuMulai: DateTime.parse(json['waktu-mulai'] as String),
      waktuSelesai: DateTime.parse(json['waktu-selesai'] as String),
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created-at'] as String),
      updatedAt: DateTime.parse(json['updated-at'] as String),
      personils: (json['personils'] as List<dynamic>?)
          ?.map((e) => PersonilModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      image: json['image'] as String?,
      deskripsi: json['deskripsi-pelanggaran'] as String?,
      jumlah: json['jumlah-pelanggar'] as int?,
      tindakan: json['tindakan-pelanggaran'] as String?,
      jenis: json['jenis'] as String?,
    )..keterangan = json['keterangan'] as String?;

Map<String, dynamic> _$KransosModelToJson(KransosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt.toIso8601String(),
      'tanggal': instance.tanggal.toIso8601String(),
      'waktu-mulai': instance.waktuMulai.toIso8601String(),
      'waktu-selesai': instance.waktuSelesai.toIso8601String(),
      'image': instance.image,
      'personils': instance.personils,
      'keterangan': instance.keterangan,
      'jenis': instance.jenis,
      'deskripsi-pelanggaran': instance.deskripsi,
      'tindakan-pelanggaran': instance.tindakan,
      'jumlah-pelanggar': instance.jumlah,
    };
