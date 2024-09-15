import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:riverpodtodo/Network/api_route.dart';
import 'package:riverpodtodo/Network/api_service.dart';
import 'package:riverpodtodo/user/model/token_resp.dart';

class UserRepositoryException implements Exception {
  final String message;
  UserRepositoryException(this.message);
}

class UserRepository {
  final ApiService _apiService;
  UserRepository(this._apiService);

  Future<TokenResp> refreshToken(String refreshToken) async {
    try {
    _apiService.setAuthToken(refreshToken);
    final TokenResp response = await _apiService.post<TokenResp>(
        ApiRoute.refreshToken,
        fromJson: TokenResp.fromJson);
    
    return response;
    } on DioException catch (e) {
      throw UserRepositoryException('Network error: ${e.message}');
    } catch (e) {
      throw UserRepositoryException('An unexpected error occurred: $e');
    }
  }

  Future<TokenResp> login(String username, String password) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      var bytes = utf8.encode('$username$password$timestamp');
      var digest = sha256.convert(bytes);

    final TokenResp response = await _apiService.post<TokenResp>(
        ApiRoute.login,
        data: {
          'username': username,
          'password': password,
          'timestamp': timestamp,
          'hash' : "$digest"
        },
        fromJson: TokenResp.fromJson);
    
    return response;
    } on DioException catch (e) {
      throw UserRepositoryException('Network error: ${e.message}');
    } catch (e) {
      throw UserRepositoryException('An unexpected error occurred: $e');
    }
  }
}
