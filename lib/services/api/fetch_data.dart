import 'package:dio/dio.dart';
import 'package:eport/routes/app_route.dart';
import 'package:eport/services/api/api_exception.dart';
import 'package:eport/services/api/request_method.dart';
import 'package:eport/services/api/sources/api.dart';
import 'package:eport/services/api/sources/api_response.dart';
import 'package:eport/utils/app_token.dart';
import 'package:eport/utils/show_alert.dart';
import 'package:get/get.dart' hide Response hide FormData;

Future<ApiResponse<T>> fetchData<T>({
  required String url,
  required RequestMethod method,
  Object? data,
  bool? isAlert = true,
  Map<String, String>? header,
  Map<String, dynamic>? queryParameters,
  String? baseUrl,
}) async {
  try {
    final api = Api(
      isFormData: data is FormData,
      baseUrl: baseUrl,
    );

    Response request = await api.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method.value),
    );

    if (T == dynamic) {
      return ApiResponse.fromJson(request.data);
    }

    ApiResponse<T> response = ApiResponse.fromJson(request.data);
    return response;
  } catch (e) {
    if (e is DioException) {
      final response = e.response;

      if (isAlert!) {
        if (response?.data is Map) {
          String message =
              response?.data['errors'] ?? 'Unknown Errors Occurred';
          if (message.toLowerCase().contains("token")) {
            logoutHandler();
          } else {
            showAlert(message);
          }
        } else {
          showAlert(response?.statusMessage ?? e.message ?? e.toString());
        }
      }
      throw ApiException(
        response?.data?['errors'] ??
            response?.statusMessage ??
            e.message ??
            e.toString(),
        code: response?.statusCode,
      );
    }
    if (isAlert!) {
      showAlert(e.toString());
    }
    rethrow;
  }
}

Future<ApiResponses<T>> fetchMultipleData<T>({
  required String url,
  required RequestMethod method,
  Object? data,
  bool? isAlert = true,
  Map<String, dynamic>? queryParameters,
  String? baseUrl,
}) async {
  try {
    final api = await Api(
      baseUrl: baseUrl,
      isFormData: data is FormData,
    );
    Response request = await api.request(
      url,
      data: data,
      queryParameters: queryParameters,
      options: Options(method: method.value),
    );

    if (T == dynamic) {
      return ApiResponses.fromJson(request.data);
    }

    ApiResponses<T> response = ApiResponses.fromJson(request.data);
    return response;
  } catch (e) {
    if (e is DioException) {
      final response = e.response;

      if (isAlert!) {
        if (response?.data is Map) {
          String message = response?.data['errors'] ?? 'Unknown';
          if (message.toLowerCase().contains("token")) {
            logoutHandler();
          } else {
            showAlert(message);
          }
        } else {
          showAlert(response?.statusMessage ?? e.message ?? e.toString());
        }
      }
      throw ApiException(
        response?.data?['message'] ??
            response?.statusMessage ??
            e.message ??
            e.toString(),
        code: response?.statusCode,
      );
    }
    if (isAlert!) {
      showAlert(e.toString());
    }
    rethrow;
  }
}

void logoutHandler() async {
  await UserToken.clearToken();
  Get.offAllNamed(AppRoute.splash);
}
