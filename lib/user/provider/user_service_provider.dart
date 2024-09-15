import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/user/provider/user_repository_provider.dart';
import 'package:riverpodtodo/user/service/user_service.dart';

final userServiceProvider = Provider<UserService>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserService(userRepository);
});

