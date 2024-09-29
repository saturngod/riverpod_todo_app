import 'package:flutter/material.dart';
import 'package:riverpodtodo/utils/token_helper.dart';
import 'package:riverpodtodo/services/user/user_repository.dart';

class UserService {

  final UserRepository _userRepository;
  UserService(this._userRepository);

  Future<bool> refreshToken(String refreshToken) async {
    try {
      final response = await _userRepository.refreshToken(refreshToken);
      final tokenHelper = TokenHelper();
      if(response.success) {
        tokenHelper.setAuthToken(response.accessToken);
        tokenHelper.setRefreshToken(response.refreshToken);
        return true;
      }
      else {
        tokenHelper.clearToken();
      }
      return false;
    } on UserRepositoryException catch (e) {
      debugPrint("FAIL to refresh token: ${e.message}");
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    try {
      final response = await _userRepository.login(username, password);
      final tokenHelper = TokenHelper();
      tokenHelper.setAuthToken(response.accessToken);
      tokenHelper.setRefreshToken(response.refreshToken);
      return true;
    } on UserRepositoryException catch (e) {
      debugPrint("FAIL to login: ${e.message}");
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String username, String password) async {
    try {
      final response = await _userRepository.register(username, password);
      return response.success;
    } on UserRepositoryException catch (e) {
      debugPrint("FAIL to register: ${e.message}");
      return false;
    } catch (e) {
      return false;
    }
  }
}