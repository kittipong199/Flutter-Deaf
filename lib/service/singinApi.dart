import 'package:app_deaf/utils/constarts.dart';
import 'package:dio/dio.dart' as dioApi hide FormData;

/// API service for signing in.
class SigninApi {
  SigninApi({dioApi.Dio? dio}) : _dio = dio ?? dioApi.Dio();

  final dioApi.Dio _dio;

  /// Sends a login request to the backend and returns the [Response].
  ///
  /// [data] is forwarded to the request body and [urllogin] is appended to
  /// the base [phpApi] URL.
  Future<dioApi.Response> logintoApp(dynamic data, String urllogin) async {
    final fulldata = phpApi + urllogin;
    return _dio.post(fulldata, data: data);
  }
}

