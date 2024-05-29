import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laporan_menu_model.g.dart';

@JsonSerializable()
class LaporanMenuModel implements ModelFactory {
  final String label;
  final String path;

  LaporanMenuModel({
    required this.label,
    required this.path,
  });

  factory LaporanMenuModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanMenuModelFromJson(json);
  Map<String, dynamic> toJson() => _$LaporanMenuModelToJson(this);
}
