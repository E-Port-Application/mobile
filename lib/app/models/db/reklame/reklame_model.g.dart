// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reklame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReklameModel _$ReklameModelFromJson(Map<String, dynamic> json) => ReklameModel(
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
      keterangan: json['keterangan'] as String?,
      nama: json['nama'] as String?,
      jenis: json['jenis'] as String?,
      pelanggaran: json['pelanggaran'] as String?,
      jumlah: json['jumlah'] as int?,
      tindakan: json['tindakan'] as String?,
    );

Map<String, dynamic> _$ReklameModelToJson(ReklameModel instance) =>
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
      'jumlah': instance.jumlah,
      'tindakan': instance.tindakan,
    };
