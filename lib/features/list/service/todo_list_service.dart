import 'package:riverpodtodo/features/list/model/todo_list.dart';
import 'package:riverpodtodo/features/list/model/todo_list_create_request.dart';
import 'package:riverpodtodo/features/list/repository/todo_list_repository.dart';

class TodoListService {

  final TodoListRepository _todoListRepository;
  TodoListService(this._todoListRepository);

  Future<List<TodoList>> getTodoList() async {
    return _todoListRepository.getTodoList();
  }

  Future<TodoList> getTodoListDetail(String id) async {
    return _todoListRepository.getTodoLisDetail(id);
  }

  Future<TodoList> createTodoList(String title) async {
    final request = TodoListCreateRequest(title: title);
    return _todoListRepository.createTodoList(request);
  }

  Future<void> deleteTodoList(String id) async {
    return _todoListRepository.deleteTodoList(id);
  }

}