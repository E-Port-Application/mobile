// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_external_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaporanExternalModel _$LaporanExternalModelFromJson(
        Map<String, dynamic> json) =>
    LaporanExternalModel(
      image: json['image'] as String,
      location: json['location'] as String,
      keluhan: json['keluhan'] as String,
      keterangan: json['keterangan'] as String,
      nama: json['nama'] as String,
      nik: json['nik'] as String,
      tanggal: DateTime.parse(
        (json['tanggal'] as Timestamp).toDate().toIso8601String(),
      ),
      createdAt: DateTime.parse(
        (json['created-at'] as Timestamp).toDate().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        (json['updated-at'] as Timestamp).toDate().toIso8601String(),
      ),
      id: json['id'] as String,
      status: json['status'] as int,
      uid: json['uid'] as String,
    );

Map<String, dynamic> _$LaporanExternalModelToJson(
        LaporanExternalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt.toIso8601String(),
      'tanggal': instance.tanggal.toIso8601String(),
      'nama': instance.nama,
      'nik': instance.nik,
      'keluhan': instance.keluhan,
      'keterangan': instance.keterangan,
      'image': instance.image,
      'status': instance.status,
      "uid": instance.uid,
      "location": instance.location,
    };
