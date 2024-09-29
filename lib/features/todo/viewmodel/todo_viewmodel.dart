import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/features/todo/model/todo.dart';
import 'package:riverpodtodo/features/todo/provider/todo_service_provider.dart';
import 'package:riverpodtodo/features/todo/service/todo_service.dart';
part 'todo_viewmodel.g.dart';

@riverpod
class TodoViewModel extends _$TodoViewModel {
  late final TodoService _todoService;
  @override
  TodoState build() {
    _todoService = ref.read(todoServiceProvider);
    return TodoState.initial();
  }

  Future<void> fetchTodos(String listId) async {
    state = state.copyWith(isLoading: true);
    try {
      final todos = await _todoService.getTodos(listId);
      state = TodoState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }

  Future<void> updateTodo(Todo todo, bool completed) async {
    state = state.copyWith(isLoading: true);
    try {
      await _todoService.updateTodo("${todo.id}", todo.title, completed);
      final newTodo = Todo(id: todo.id, title: todo.title, completed: completed, createdAt: todo.createdAt, updatedAt: todo.updatedAt, listId: todo.listId);

      final todos = state.todos.map((e) => e.id == todo.id ? newTodo : e).toList();
      state = TodoState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }

  Future<void> deleteTodo(Todo todo) async {
    state = state.copyWith(isLoading: true);
    try {
      await _todoService.deleteTodoList("${todo.id}");
      final todos = state.todos.where((element) => element.id != todo.id).toList();
      state = TodoState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }

  Future<Todo> addTodo(String title,int listId) async {
    state = state.copyWith(isLoading: true);
    try {
      final todo = await _todoService.createTodo(title, listId);
      final todos = [...state.todos, todo];
      state = TodoState.success(todos);
      return todo;
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
      throw Exception('An unexpected error occurred: $e');
    }
  }

}

class TodoState {
  final bool isLoading;
  final String? errorMessage;
  final List<Todo> todos;

  TodoState({required this.isLoading,this.errorMessage,required this.todos});

  factory TodoState.initial() => TodoState(isLoading: false,todos: []);

  factory TodoState.success(List<Todo> todos) => TodoState(isLoading: false,todos: todos, errorMessage: null);

  TodoState copyWith({bool? isLoading, String? errorMessage, List<Todo>? todos}) {
    return TodoState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      todos: todos ?? this.todos
    );
  }
  
}