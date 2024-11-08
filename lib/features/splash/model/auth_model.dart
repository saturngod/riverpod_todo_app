import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/features/splash/provider/auth_service_provider.dart';
import 'package:riverpodtodo/features/splash/service/auth_service.dart';

part 'auth_model.g.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}


@riverpod
class AuthModel extends _$AuthModel{
  late final AuthService _authService;
   
  @override
  AuthStatus build()  {
    _authService = ref.watch(authServiceProvider);
    return AuthStatus.unauthenticated;
  }

  Future<AuthStatus> checkAuthStatus() async {
    return _authService.checkAuthStatus();
  }

  Future<String?> getAuthToken() async {
    return _authService.getAuthToken();
  }

  void logout(){
    _authService.logout();
  }
}