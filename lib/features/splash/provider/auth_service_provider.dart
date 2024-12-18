import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/utils/provider/token_helper_provider.dart';
import 'package:riverpodtodo/features/splash/service/auth_service.dart';
import 'package:riverpodtodo/services/user/provider/user_service_provider.dart';

part 'auth_service_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  final tokenHelper = ref.read(tokenHelperProvider);
  final userService = ref.read(userServiceProvider);
  return AuthService(tokenHelper, userService);
}