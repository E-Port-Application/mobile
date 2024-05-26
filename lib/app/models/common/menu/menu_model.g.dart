// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuModel _$MenuModelFromJson(Map<String, dynamic> json) => MenuModel(
      iconActive: json['icon-active'] as String,
      iconInactive: json['icon-inactive'] as String,
      label: json['label'] as String,
      path: json['path'] as String,
    );

Map<String, dynamic> _$MenuModelToJson(MenuModel instance) => <String, dynamic>{
      'label': instance.label,
      'path': instance.path,
      'icon-inactive': instance.iconInactive,
      'icon-active': instance.iconActive,
    };
