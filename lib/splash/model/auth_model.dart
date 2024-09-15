import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/Utils/token_helper.dart';
import 'package:riverpodtodo/user/provider/user_service_provider.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AuthModel {
  final TokenHelper tokenHelper;
  final AutoDisposeFutureProviderRef ref;
  AuthModel(this.tokenHelper, this.ref);

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
}