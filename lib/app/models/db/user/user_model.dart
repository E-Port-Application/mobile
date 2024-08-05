import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel implements ModelFactory {
  final String? displayName;
  final String? email;
  final bool emailVerified;
  final String? phoneNumber;
  final String? photoURL;
  final String uid;
  final bool internal;
  String? role = "default";

  UserModel({
    required this.displayName,
    required this.email,
    required this.emailVerified,
    required this.phoneNumber,
    required this.photoURL,
    required this.uid,
    required this.internal,
    this.role = "default",
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
