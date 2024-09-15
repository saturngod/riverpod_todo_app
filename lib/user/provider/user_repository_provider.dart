import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/Network/todo_api.dart';
import 'package:riverpodtodo/user/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService);
});