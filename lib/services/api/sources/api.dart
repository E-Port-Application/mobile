import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContentTypeInterceptor extends Interceptor {
  static const String jsonContentType = 'application/json';
  static const String multipartContentType = 'multipart/form-data';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.data is Map<String, dynamic> || options.data is List<dynamic>) {
      options.headers['Content-Type'] = jsonContentType;
    } else if (options.data is FormData) {
      options.headers['Content-Type'] = multipartContentType;
    }

    super.onRequest(options, handler);
  }
}

Dio Api({
  bool? isFormData = false,
  String? baseUrl,
}) {
  final dio = Dio();
  dio.options.baseUrl = baseUrl ?? dotenv.env['BASE_URL']!;

  var header = {
    'Accept': 'application/json',
    'x-device-type': 'mobile',
  };
  dio.options.connectTimeout = Duration(seconds: 60);
  dio.options.receiveTimeout = Duration(seconds: 60);
  dio.options.headers.addAll(header);

  dio.interceptors.add(ContentTypeInterceptor());

  return dio;
}
