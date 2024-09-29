import 'package:riverpodtodo/features/list/model/todo_list.dart';
import 'package:riverpodtodo/features/list/repository/todo_list_repository.dart';
import 'package:riverpodtodo/features/todo/model/todo.dart';
import 'package:riverpodtodo/features/todo/model/todo_create_request.dart';
import 'package:riverpodtodo/features/todo/model/todo_request.dart';
import 'package:riverpodtodo/features/todo/repository/todo_repository.dart';

class TodoService {

  late final TodoListRepository _todoListRepository;
  late final TodoRepository _todoRepository;

  TodoService(this._todoListRepository, this._todoRepository);

  Future<List<Todo>> getTodos(String listId) async {
    try {
      TodoList list = await _todoListRepository.getTodoLisDetail(listId);
      return list.todos ?? [];
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> deleteTodoList(String id) async {
    return _todoListRepository.deleteTodoList(id);
  }

  Future<void> updateTodo(String id,String title,bool completed) async {
    final request = TodoUpdateRequest(title: title, completed: completed);
    return _todoRepository.editTodo(request, id);
  }

  Future<Todo> createTodo(String title,int listId) async {
    final request = TodoCreateRequest(title: title, listId: listId);
    return _todoRepository.createTodo(request);
  }
  
}