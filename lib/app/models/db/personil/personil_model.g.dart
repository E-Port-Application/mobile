// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personil_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonilModel _$PersonilModelFromJson(Map<String, dynamic> json) =>
    PersonilModel(
      id: json['id'] as String,
      komando: json['komando'] as bool,
      name: json['name'] as String,
      regu: json['regu'] as String?,
      hadir: json['hadir'] as bool? ?? false,
    );

Map<String, dynamic> _$PersonilModelToJson(PersonilModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'komando': instance.komando,
      'regu': instance.regu,
      'hadir': instance.hadir,
    };
