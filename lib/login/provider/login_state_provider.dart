import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/login/viewmodel/login_view_model.dart';
import 'package:riverpodtodo/user/provider/user_service_provider.dart';

final loginStateProvider = StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final userService = ref.read(userServiceProvider);
  return LoginViewModel(userService);
});