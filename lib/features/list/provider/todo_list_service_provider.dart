import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/network/todo_api.dart';
import 'package:riverpodtodo/core/utils/provider/token_helper_provider.dart';
import 'package:riverpodtodo/core/utils/token_helper.dart';
import 'package:riverpodtodo/features/list/repository/todo_list_repository.dart';
import 'package:riverpodtodo/features/list/service/todo_list_service.dart';

part 'todo_list_service_provider.g.dart';

@riverpod
TodoListRepository todoListRepository(TodoListRepositoryRef ref) {
  final TokenHelper tokenHelper = ref.read(tokenHelperProvider);
  return TodoListRepository(tokenHelper, ref.read(apiServiceProvider));
}

@riverpod
TodoListService todoListService(TodoListServiceRef ref) {
  return TodoListService(ref.read(todoListRepositoryProvider));
}