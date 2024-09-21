import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/Utils/token_helper.dart';
import 'package:riverpodtodo/services/user/provider/user_service_provider.dart';

part 'auth_model.g.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}


@riverpod
class AuthModel extends _$AuthModel{
  final TokenHelper tokenHelper = TokenHelper();
  
  @override
  AuthStatus build()  {
    return AuthStatus.unauthenticated;
  }

  Future<AuthStatus> checkAuthStatus() async {
    final String? token = await tokenHelper.getAuthToken();
    if (token != null) {
      TokenHelper tokenHelper = TokenHelper();
      
      if (tokenHelper.isTokenValid(token)) {
        return AuthStatus.authenticated;
      }
      
      final userService = ref.watch(userServiceProvider);
      final success = await userService.refreshToken(token);
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

  void logout(){
    tokenHelper.clearToken();
  }
}