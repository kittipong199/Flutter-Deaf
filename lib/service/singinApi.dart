import 'package:app_deaf/utils/constarts.dart';
import 'package:dio/dio.dart' as dioApi hide FormData;

class SigninApi {
  Future<dioApi.Response> logintoApp(data, String urllogin) async {
    var fulldata = phpApi + urllogin;

    var dio = dioApi.Dio();

    try {
      return await dio.post(fulldata, data: data);
    } on dioApi.DioError catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      throw Exception('Login request failed: ${e.message}');
    }
  }
}
