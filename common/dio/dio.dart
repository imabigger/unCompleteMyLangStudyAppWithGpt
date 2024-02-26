import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.interceptors.add(
    CustomInterceptor(ref: ref),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  final Ref ref;

  CustomInterceptor({required this.ref});

  // 1) 요청을 보낼때
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('[REQ] [${options.method}] ${options.uri}');

    return super.onRequest(options, handler);
  }

  //2 응답을 받았을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        '[RES] [${response.requestOptions.method}] ${response.requestOptions.uri}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // error : 401 -> 토큰을 재발급 하는 시도, 재발급 되면 다시 새로운 토큰으로 요청
    print('[ERR] [${err.requestOptions.method}] ${err.requestOptions.uri}');
    print(err.message);


    return handler.reject(err);
  }
}
