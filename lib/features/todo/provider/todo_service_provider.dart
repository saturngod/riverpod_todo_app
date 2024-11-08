import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/network/api_service.dart';
import 'package:riverpodtodo/core/network/api_service_provider.dart';
import 'package:riverpodtodo/core/utils/provider/token_helper_provider.dart';
import 'package:riverpodtodo/core/utils/token_helper.dart';
import 'package:riverpodtodo/features/list/provider/todo_list_service_provider.dart';
import 'package:riverpodtodo/features/list/repository/todo_list_repository.dart';
import 'package:riverpodtodo/features/todo/repository/todo_repository.dart';
import 'package:riverpodtodo/features/todo/service/todo_service.dart';

part 'todo_service_provider.g.dart';

@riverpod
TodoRepository todoRepository(Ref ref) {
  final TokenHelper tokenHelper = ref.read(tokenHelperProvider);
  final ApiService apiService = ref.read(apiServiceProvider);
  return TodoRepository(tokenHelper, apiService);
}

@riverpod
TodoService todoService(Ref ref) {
  TodoRepository todoRepository = ref.read(todoRepositoryProvider);
  TodoListRepository todoListRepository = ref.read(todoListRepositoryProvider);
  return TodoService(todoListRepository, todoRepository);
}