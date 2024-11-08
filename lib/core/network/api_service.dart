import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpodtodo/core/network/base_request.dart';
import 'package:riverpodtodo/core/network/base_response.dart';

class ApiService {
  final String baseUrl;
  late final Dio _dio;

  ApiService(this.baseUrl) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint("Request: ${options.method} ${options.path}");
        debugPrint("Headers: ${options.headers}");
        debugPrint("Data: ${options.data}");
        handler.next(options); // Continue with the request
      },
      onResponse: (response, handler) {
        debugPrint("Response: ${response.statusCode} ${response.data}");
        handler.next(response); // Continue with the response
      },
      onError: (DioException e, handler) {
        debugPrint("Error occurred: ${e.message}");
        handler.next(e); // Continue with error handling
      },
    ));
  }

  void setAuthToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  void clearAuthToken() {
    _dio.options.headers.remove('Authorization');
  }

  Future<Response> _request(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final requestData = (data is BaseRequest) ? data.toJson() : data;

      return await _dio.request(path,
          data: requestData,
          queryParameters: queryParameters,
          options: Options(
            method: method,
            headers: data,
          ));
    } on DioException catch (e) {
      // Handle Dio-specific errors here (network issues, timeouts, etc.)
      throw Exception('Failed request: ${e.message}');
    }
  }

  List<T> _processListResponse<T extends BaseResponse>(
      Response response, T Function(Map<String, dynamic>) fromJson) {
    if (response.data is List) {
      return (response.data as List)
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw const FormatException('Response is not a list');
    }
  }

  Future<List<T>> _handleListRequest<T extends BaseResponse>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    final response = await _request(
      path,
      method: method,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
    return _processListResponse(response, fromJson);
  }

  Future<T?> _handleRequest<T extends BaseResponse?>(
    String path, {
    required String method,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    final response = await _request(
      path,
      method: method,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
    if (fromJson != null) {
      return fromJson(response.data);
    }
    return null;
  }

  Future<List<T>> getList<T extends BaseResponse>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    return _handleListRequest(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<T?> get<T extends BaseResponse?>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleRequest<T>(
      path,
      method: 'GET',
      queryParameters: queryParameters,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<List<T>> postList<T extends BaseResponse>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    return _handleListRequest(
      path,
      method: 'POST',
      data: data,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<T?> post<T extends BaseResponse?>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleRequest<T>(
      path,
      method: 'POST',
      data: data,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<List<T>> putList<T extends BaseResponse>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    return _handleListRequest<T>(
      path,
      method: 'PUT',
      data: data,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<T?> put<T extends BaseResponse?>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleRequest<T>(
      path,
      method: 'PUT',
      data: data,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<List<T>> deleteList<T extends BaseResponse>(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    return _handleListRequest<T>(
      path,
      method: 'DELETE',
      data: data,
      headers: headers,
      fromJson: fromJson,
    );
  }

  Future<T?> delete<T extends BaseResponse?>(
    String path, {
    Map<String, dynamic>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _handleRequest<T>(
      path,
      method: 'DELETE',
      headers: headers,
      fromJson: fromJson,
    );
  }
}