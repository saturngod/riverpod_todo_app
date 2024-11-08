import 'package:riverpodtodo/core/utils/token_helper.dart';
import 'package:riverpodtodo/features/splash/model/auth_model.dart';
import 'package:riverpodtodo/services/user/user_service.dart';

class AuthService {
  final TokenHelper _tokenHelper;
  final UserService _userService;
  AuthService(this._tokenHelper, this._userService);

  Future<String?> getAuthToken() async {
    return _tokenHelper.getAuthToken();
  }

  Future<AuthStatus> checkAuthStatus() async {
    final String? token = await _tokenHelper.getAuthToken();
    if (token != null) {
      
      if (_tokenHelper.isTokenValid(token)) {
        return AuthStatus.authenticated;
      }
      
      final success = await _userService.refreshToken(token);
      if (success) {
        return AuthStatus.authenticated;
      }
      else {
        return AuthStatus.unauthenticated;
      }
      
    }
    else {
      return AuthStatus.unauthenticated;
    }
  }

  void logout() {
    _tokenHelper.clearToken();
  }
}