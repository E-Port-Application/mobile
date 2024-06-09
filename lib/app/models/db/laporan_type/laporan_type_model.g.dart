// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporan_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LaporanTypeModel _$LaporanTypeModelFromJson(Map<String, dynamic> json) =>
    LaporanTypeModel(
      label: json['label'] as String,
      value: json['value'] as String,
      id: json['id'] as String,
    );

Map<String, dynamic> _$LaporanTypeModelToJson(LaporanTypeModel instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'id': instance.id,
    };
