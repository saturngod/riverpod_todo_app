import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/user/service/user_service.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final UserService _userService;
  
  LoginViewModel(this._userService) : super(LoginState.initial());

  Future<void> login(String username, String password) async {
    state = LoginState.loading();
    try {
      final success = await _userService.login(username, password);
      if (success) {
        state = LoginState.success();
      } else {
        state = LoginState.error('Invalid login');
      }
    } catch (e) {
      state = LoginState.error('Something went wrong');
    }
  }
}

class LoginState {
  final bool isLoggedIn;
  final bool isLoading;
  final String? errorMessage;

  LoginState({required this.isLoggedIn, required this.isLoading, this.errorMessage});


  factory LoginState.initial() => LoginState(isLoggedIn: false, isLoading: false);

  factory LoginState.success() => LoginState(isLoggedIn: true, isLoading: false);

  factory LoginState.loading() => LoginState(isLoggedIn: false, isLoading: true);

  factory LoginState.error(String errorMessage) => LoginState(
        isLoggedIn: false,
        isLoading: false,
        errorMessage: errorMessage,
      );
}