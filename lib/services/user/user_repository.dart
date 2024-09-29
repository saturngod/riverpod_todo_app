import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:riverpodtodo/Network/api_route.dart';
import 'package:riverpodtodo/Network/api_service.dart';
import 'package:riverpodtodo/services/user/model/register_resp.dart';
import 'package:riverpodtodo/services/user/model/token_resp.dart';

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
      final TokenResp? response = await _apiService
          .post<TokenResp>(ApiRoute.refreshToken, fromJson: TokenResp.fromJson);
      if (response == null) {
        throw UserRepositoryException('Failed to refresh token');
      }
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

      final TokenResp? response =
          await _apiService.post<TokenResp>(ApiRoute.login,
              data: {
                'username': username,
                'password': password,
                'timestamp': timestamp,
                'hash': "$digest"
              },
              fromJson: TokenResp.fromJson);
      if (response == null) {
        throw UserRepositoryException('Failed to refresh token');
      }
      return response;
    } on DioException catch (e) {
      throw UserRepositoryException('Network error: ${e.message}');
    } catch (e) {
      throw UserRepositoryException('An unexpected error occurred: $e');
    }
  }

  Future<RegisterResp> register(String username, String password) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      var bytes = utf8.encode('$username$password$timestamp');
      var digest = sha256.convert(bytes);

      final RegisterResp? response =
          await _apiService.post<RegisterResp>(ApiRoute.register,
              data: {
                'username': username,
                'password': password,
                'timestamp': timestamp,
                'hash': "$digest"
              },
              fromJson: RegisterResp.fromJson);
      if (response == null) {
        throw UserRepositoryException('Failed to refresh token');
      }
      return response;
    } on DioException catch (e) {
      throw UserRepositoryException('Network error: ${e.message}');
    } catch (e) {
      throw UserRepositoryException('An unexpected error occurred: $e');
    }
  }
}
