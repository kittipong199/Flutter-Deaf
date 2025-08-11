import 'package:app_deaf/service/singinApi.dart';
import 'package:app_deaf/utils/constarts.dart';
import 'package:dio/dio.dart' as dioApi;
import 'package:flutter_test/flutter_test.dart';

class MockDio extends dioApi.Dio {
  MockDio(this.mockResponse);

  final dioApi.Response mockResponse;
  String? lastPath;
  dynamic lastData;

  @override
  Future<dioApi.Response<T>> post<T>(String path,
      {data,
      dioApi.Options? options,
      dioApi.CancelToken? cancelToken,
      dioApi.ProgressCallback? onSendProgress,
      dioApi.ProgressCallback? onReceiveProgress}) async {
    lastPath = path;
    lastData = data;
    return mockResponse as dioApi.Response<T>;
  }
}

void main() {
  test('logintoApp sends data and handles response', () async {
    final mockResponse = dioApi.Response(
      requestOptions: dioApi.RequestOptions(path: ''),
      data: {'status': 'ok'},
      statusCode: 200,
    );

    final mockDio = MockDio(mockResponse);
    final api = SigninApi(dio: mockDio);
    final data = {'user': 'alice'};
    final result = await api.logintoApp(data, '/login');

    expect(mockDio.lastPath, phpApi + '/login');
    expect(mockDio.lastData, data);
    expect(result.data, {'status': 'ok'});
  });
}

