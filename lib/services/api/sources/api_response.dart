import 'package:eport/services/api/sources/base_response.dart';
import 'package:eport/services/api/sources/model_factory.dart';
import 'package:json_annotation/json_annotation.dart';

class ApiResponse<T> extends BaseResponse {
  final T? data;

  ApiResponse({
    this.data,
    required super.status,
    super.message,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json['data'] == null) {
      return ApiResponse<T>(
        message: json["message"],
        status: json["status"],
      );
    }
    if (T == dynamic || json['data'].runtimeType == String) {
      return ApiResponse<T>(
        message: json["message"],
        status: json["status"],
        data: json['data'],
      );
    }
    return ApiResponse<T>(
      message: json["message"],
      status: json["status"],
      data: Converter<T>().fromJson(json['data']),
    );
  }
}

class ApiResponses<T> extends BaseResponse {
  List<T>? data;

  ApiResponses({
    this.data,
    required super.message,
    required super.status,
  });

  factory ApiResponses.fromJson(
    Map<String, dynamic> json,
  ) {
    if (json['data'] == null) {
      return ApiResponses<T>(
        message: json["message"],
        status: json["status"],
      );
    }
    if (T == dynamic || json['data'].runtimeType == String) {
      return ApiResponses<T>(
        message: json["message"],
        status: json["status"],
        data: json['data'],
      );
    }
    return ApiResponses<T>(
      message: json["message"],
      status: json["status"],
      data: List<T>.from((json["results"] ?? json["data"])
          .map((x) => Converter<T?>().fromJson(x))),
    );
  }
}

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
