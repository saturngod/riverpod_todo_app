import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/network/api_service_provider.dart';
import 'package:riverpodtodo/services/user/user_repository.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepository(apiService);
}
