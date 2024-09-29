import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/features/list/model/todo_list.dart';
import 'package:riverpodtodo/features/list/provider/todo_list_service_provider.dart';
import 'package:riverpodtodo/features/list/service/todo_list_service.dart';

part 'todo_list_viewmodel.g.dart';

@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  late final TodoListService _todoService;

  @override
  TodoListState build() {
    _todoService = ref.read(todoListServiceProvider);
    return TodoListState.initial();
  }

  Future<void> fetchTodos() async {
    state = state.copyWith(isLoading: true);
    try {
      final todos = await _todoService.getTodoList();
      state = TodoListState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }

  Future<void> addTodoList(String title) async {
    state = state.copyWith(isLoading: true);
    try {
      final todo = await _todoService.createTodoList(title);
      final todos = [...state.todos, todo];
      state = TodoListState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }

  Future<void> deleteTodoList(String id) async {
    state = state.copyWith(isLoading: true);
    try {
      await _todoService.deleteTodoList(id);
      final todos = state.todos.where((element) => element.id != int.parse(id)).toList();
      state = TodoListState.success(todos);
    } catch (e) {
      state = state.copyWith(errorMessage: 'Something went wrong',isLoading: false);
    }
  }
  
}

class TodoListState {
  final List<TodoList> todos;
  final bool isLoading;

  final String? errorMessage;

  TodoListState(
      {required this.todos,
      required this.isLoading,
      
      this.errorMessage});

  factory TodoListState.initial() =>
      TodoListState(todos: [], isLoading: false);

  factory TodoListState.success(List<TodoList> todos) =>
      TodoListState(todos: todos, isLoading: false, errorMessage: null);

  TodoListState copyWith({
    List<TodoList>? todos,
    bool? isLoading,
    String? addTodoTitle,
    String? errorMessage,
  }) =>
      TodoListState(
          todos: todos ?? this.todos,
          isLoading: isLoading ?? this.isLoading,
          
          errorMessage: errorMessage ?? this.errorMessage);

}