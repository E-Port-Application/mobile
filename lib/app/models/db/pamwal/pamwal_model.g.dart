// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pamwal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PamwalModel _$PamwalModelFromJson(Map<String, dynamic> json) => PamwalModel(
      tanggal: DateTime.parse(json['tanggal'] as String),
      waktuMulai: DateTime.parse(json['waktu-mulai'] as String),
      waktuSelesai: DateTime.parse(json['waktu-selesai'] as String),
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created-at'] as String),
      updatedAt: DateTime.parse(json['updated-at'] as String),
      personils: (json['personils'] as List<dynamic>?)
          ?.map((e) => PersonilModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      kejadian: json['kejadian'] as String?,
      tindakan: json['tindakan'] as String?,
    )
      ..image = json['image'] as String?
      ..keterangan = json['keterangan'] as String?;

Map<String, dynamic> _$PamwalModelToJson(PamwalModel instance) =>
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
      'kejadian': instance.kejadian,
      'tindakan': instance.tindakan,
    };
