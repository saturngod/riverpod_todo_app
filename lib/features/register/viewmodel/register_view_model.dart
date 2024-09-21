import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/services/user/provider/user_service_provider.dart';
import 'package:riverpodtodo/services/user/user_service.dart';

part 'register_view_model.g.dart';

@riverpod
class RegisterViewModel extends _$RegisterViewModel {
  
  late final UserService _userService;

  @override
  RegisterState build() {
    _userService = ref.read(userServiceProvider);
    return RegisterState.initial();
  }

  Future<void> register() async {
    state = state.copyWith(isLoading: true);
    try {
      final success = await _userService.register(state.username, state.password);
      if (success) {
        state = state.copyWith(isSuccess: true, isLoading: false);
      } else {
        state = state.copyWith(isLoading: false, errorMessage: 'Invalid login');
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'Something went wrong');
    }
  }

  void updateUsername(String username) {
    state = state.copyWith(username: username);
    _validateForm();
  }

  void updatePassword(String password) {
    state = state.copyWith(password: password);
    _validateForm();
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(confirmPassword: confirmPassword);
    _validateForm();
  }

  void _validateForm() {
    final isFormValid = state.username.isNotEmpty &&
        state.password.isNotEmpty &&
        state.confirmPassword.isNotEmpty &&
        state.password == state.confirmPassword;

    final errorMessage = state.password != state.confirmPassword
        ? 'Passwords do not match'
        : null;

    state = state.copyWith(isFormValid: isFormValid, errorMessage: errorMessage);
  }
}

class RegisterState {
  final String username;
  final String password;
  final String confirmPassword;
  final bool isSuccess;
  final bool isLoading;
  final bool isFormValid;
  final String? errorMessage;

  RegisterState({
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.isSuccess,
    required this.isLoading,
    required this.isFormValid,
    this.errorMessage,
  });

  factory RegisterState.initial() => RegisterState(
        username: '',
        password: '',
        confirmPassword: '',
        isSuccess: false,
        isLoading: false,
        isFormValid: false,
      );

  RegisterState copyWith({
    String? username,
    String? password,
    String? confirmPassword,
    bool? isSuccess,
    bool? isLoading,
    bool? isFormValid,
    String? errorMessage,
  }) {
    return RegisterState(
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSuccess: isSuccess ?? this.isSuccess,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage,
    );
  }
}