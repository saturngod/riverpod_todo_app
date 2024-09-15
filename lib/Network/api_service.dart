import 'package:dio/dio.dart';
import 'package:riverpodtodo/Network/base_response.dart';

class ApiService {
  final String baseUrl;
  late final Dio _dio;

  ApiService(this.baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<T> get<T extends BaseResponse>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await _dio.get(path,
        queryParameters: queryParameters, options: Options(headers: headers));
    return fromJson(response.data);
  }

  Future<T> post<T extends BaseResponse>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response =
        await _dio.post(path, data: data, options: Options(headers: headers));
    return fromJson(response.data);
  }

  Future<T> put<T extends BaseResponse>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response =
        await _dio.put(path, data: data, options: Options(headers: headers));
    return fromJson(response.data);
  }

  Future<T> delete<T extends BaseResponse>(
    String path, {
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response =
        await _dio.delete(path, options: Options(headers: headers));
    return fromJson(response.data);
  }
}
