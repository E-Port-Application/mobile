// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaporanModel _$LaporanModelFromJson(Map<String, dynamic> json) => LaporanModel(
      id: json['id'] as String,
      type: json['type'] as String,
      progress: json['progress'] as bool,
      data: json['data'],
    );

Map<String, dynamic> _$LaporanModelToJson(LaporanModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'progress': instance.progress,
      'data': instance.data,
    };
