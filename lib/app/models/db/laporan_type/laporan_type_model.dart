import 'package:eport/app/presentation/widgets/app_radio.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'laporan_type_model.g.dart';

@JsonSerializable()
class LaporanTypeModel extends RadioProps implements ModelFactory {
  final String id;

  LaporanTypeModel({
    required super.label,
    required String super.value,
    required this.id,
  });

  factory LaporanTypeModel.fromJson(Map<String, dynamic> json) =>
      _$LaporanTypeModelFromJson(json);
  Map<String, dynamic> toJson() => _$LaporanTypeModelToJson(this);
}
