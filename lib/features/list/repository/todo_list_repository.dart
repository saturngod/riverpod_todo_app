import 'package:riverpodtodo/core/network/api_route.dart';
import 'package:riverpodtodo/core/network/api_service.dart';
import 'package:riverpodtodo/core/utils/token_helper.dart';
import 'package:riverpodtodo/features/list/model/todo_list.dart';
import 'package:riverpodtodo/features/list/model/todo_list_create_request.dart';

class TodoListRepository {
  final ApiService _apiService;
  TodoListRepository(TokenHelper tokenHelper,this._apiService, );

  Future<List<TodoList>> getTodoList() async {
    try {
      final List<TodoList> response = await _apiService.getList(ApiRoute.list, fromJson: TodoList.fromJson);
      return response;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<TodoList> getTodoLisDetail(String id) async {
    try {
      final TodoList? response = await _apiService.get(ApiRoute.listWithId(id), fromJson: TodoList.fromJson);
      if (response == null) {
        throw Exception('Todo list not found');
      }
      return response;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }


  Future<TodoList> createTodoList(TodoListCreateRequest request) async {
    try {
      final TodoList? response = await _apiService.post<TodoList>(
          ApiRoute.list,
          data: request,
          fromJson: TodoList.fromJson);
      if (response == null) {
        throw Exception('Failed to create todo list');
      }
      return response;
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> deleteTodoList(String id) async {
    try {
      await _apiService.delete(ApiRoute.listWithId(id));
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}