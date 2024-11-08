import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/services/user/provider/user_repository_provider.dart';
import 'package:riverpodtodo/services/user/user_service.dart';

part 'user_service_provider.g.dart';

@riverpod
UserService userService(Ref ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository);
}

