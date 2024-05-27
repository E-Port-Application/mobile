import 'package:eport/app/models/common/menu/menu_model.dart';
import 'package:eport/app/models/common/profile/profile_model.dart';

abstract class ModelFactory {
  factory ModelFactory.fromJson(Type type, Map<String, dynamic> json) {
    final strType = type.toString().replaceAll("?", "");
    if (strType == (MenuModel).toString()) {
      return MenuModel.fromJson(json);
    } else if (strType == (ProfileModel).toString()) {
      return ProfileModel.fromJson(json);
    }

    throw UnimplementedError();
  }
}
