import 'package:riverpodtodo/network/api_route.dart';
import 'package:riverpodtodo/network/api_service.dart';
import 'package:riverpodtodo/utils/token_helper.dart';
import 'package:riverpodtodo/features/todo/model/todo.dart';
import 'package:riverpodtodo/features/todo/model/todo_create_request.dart';
import 'package:riverpodtodo/features/todo/model/todo_request.dart';

class TodoRepository {
  final ApiService _apiService;
  TodoRepository(TokenHelper tokenHelper,this._apiService, ) {
    tokenHelper.getAuthToken().then((value) => _apiService.setAuthToken(value ?? ""));
  }

  Future<void> deleteTodo(String todoId) async {
    try {
      await _apiService.delete(ApiRoute.todoWithId(todoId));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
  
  Future<void> editTodo(TodoUpdateRequest request, String todoId) async {
    try {
      await _apiService.put(ApiRoute.todoWithId(todoId), data: request);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<Todo> createTodo(TodoCreateRequest request) async {
    try {
      final Todo? response = await _apiService.post<Todo>(
          ApiRoute.todo,
          data: request,
          fromJson: Todo.fromJson);
      if (response == null) {
        throw Exception('Failed to create todo list');
      }
      return response;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}