// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaporanModel _$LaporanModelFromJson(Map<String, dynamic> json) => LaporanModel(
      id: json['id'] as String,
      type: json['type'] as String,
      progress: json['progress'] as bool,
      date: DateTime.parse(json['date'] as String),
      data: json['data'],
      createdAt: DateTime.parse(json['created-at'] as String),
      updatedAt: DateTime.parse(json['updated-at'] as String),
    );

Map<String, dynamic> _$LaporanModelToJson(LaporanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created-at': instance.createdAt.toIso8601String(),
      'updated-at': instance.updatedAt.toIso8601String(),
      'type': instance.type,
      'progress': instance.progress,
      'date': instance.date.toIso8601String(),
      'data': instance.data,
    };
