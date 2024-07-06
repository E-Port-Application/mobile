// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kransos_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KransosModel _$KransosModelFromJson(Map<String, dynamic> json) => KransosModel(
      tanggal: DateTime.parse(
        (json['tanggal'] as Timestamp).toDate().toIso8601String(),
      ),
      waktuMulai: DateTime.parse(
        (json['waktu-mulai'] as Timestamp).toDate().toIso8601String(),
      ),
      waktuSelesai: DateTime.parse(
        (json['waktu-selesai'] as Timestamp).toDate().toIso8601String(),
      ),
      id: json['id'] as String,
      createdAt: DateTime.parse(
        (json['created-at'] as Timestamp).toDate().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        (json['updated-at'] as Timestamp).toDate().toIso8601String(),
      ),
      location: json['location'] as String,
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
      'personils': instance.personils?.map((e) => e.toJson()).toList(),
      'keterangan': instance.keterangan,
      'location': instance.location,
      'jenis': instance.jenis,
      'deskripsi-pelanggaran': instance.deskripsi,
      'tindakan-pelanggaran': instance.tindakan,
      'jumlah-pelanggar': instance.jumlah,
    };
