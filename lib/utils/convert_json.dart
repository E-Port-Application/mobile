import 'dart:convert' hide Converter;

import 'package:eport/services/api/sources/model_factory.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';

class Converter<T> implements JsonConverter<T?, Object?> {
  const Converter();

  @override
  T? fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      return ModelFactory.fromJson(T, json) as T;
    }
    return json as Null;
  }

  @override
  Object toJson(T? object) {
    return (object as Object);
  }
}

Future<List<T>> convertJson<T>(String path) async {
  final String response = await rootBundle.loadString(path);
  final map = json.decode(response);
  final res = List<T>.from((map).map((x) => Converter<T?>().fromJson(x)));
  return res;
}
