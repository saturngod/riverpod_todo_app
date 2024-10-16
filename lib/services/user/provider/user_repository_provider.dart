import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/network/todo_api.dart';
import 'package:riverpodtodo/services/user/user_repository.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService);
}
