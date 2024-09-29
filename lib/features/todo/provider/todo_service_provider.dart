import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/network/todo_api.dart';
import 'package:riverpodtodo/utils/provider/token_helper_provider.dart';
import 'package:riverpodtodo/utils/token_helper.dart';
import 'package:riverpodtodo/features/list/provider/todo_list_service_provider.dart';
import 'package:riverpodtodo/features/list/repository/todo_list_repository.dart';
import 'package:riverpodtodo/features/todo/repository/todo_repository.dart';
import 'package:riverpodtodo/features/todo/service/todo_service.dart';

part 'todo_service_provider.g.dart';

@riverpod
TodoRepository todoRepository(TodoRepositoryRef ref) {
  final TokenHelper tokenHelper = ref.read(tokenHelperProvider);
  return TodoRepository(tokenHelper, ref.read(apiServiceProvider));
}

@riverpod
TodoService todoService(TodoServiceRef ref) {
  TodoRepository todoRepository = ref.read(todoRepositoryProvider);
  TodoListRepository todoListRepository = ref.read(todoListRepositoryProvider);
  return TodoService(todoListRepository, todoRepository);
}