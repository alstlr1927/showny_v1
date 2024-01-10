import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:showny/api/rest_client.dart';

final restProvider = Provider<RestClient>((ref) {
  Dio dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
      onResponse: (Response response, ResponseInterceptorHandler handler) {
    debugPrint(response.data.toString()); // 이 부분을 원하는 로깅 방식으로 변경
    return handler.next(response); // continue
  }, onError: (DioError e, ErrorInterceptorHandler handler) {
    debugPrint(e.toString()); // 이 부분을 원하는 로깅 방식으로 변경
    return handler.next(e); // continue
  }, onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint("REQUEST: ${options.method} ${options.uri}");
    debugPrint("HEADERS: ${options.headers}");
    debugPrint("QUERY PARAMETERS: ${options.queryParameters}");
    debugPrint("DATA: ${options.data}");
    return handler.next(options); // continue
  }));
  return RestClient(dio);
});
