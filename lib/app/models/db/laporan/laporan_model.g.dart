// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaporanModel _$LaporanModelFromJson(Map<String, dynamic> json) => LaporanModel(
      id: json['id'] as String,
      type: json['type'] as String,
      progress: json['progress'] as bool,
      date: DateTime.parse(
        (json['date'] as Timestamp).toDate().toIso8601String(),
      ),
      data: json['data'],
      location: json['location'] as String?,
      isExternal: json['isExternal'] as bool?,
      createdAt: DateTime.parse(
        (json['created-at'] as Timestamp).toDate().toIso8601String(),
      ),
      updatedAt: DateTime.parse(
        (json['updated-at'] as Timestamp).toDate().toIso8601String(),
      ),
    );

Map<String, dynamic> _$LaporanModelToJson(LaporanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt.toIso8601String(),
      'type': instance.type,
      'progress': instance.progress,
      'location': instance.location,
      'isExternal': instance.isExternal,
      'date': instance.date.toIso8601String(),
      'data': instance.data,
    };
