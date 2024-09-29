import 'package:riverpodtodo/Network/base_response.dart';
import 'package:riverpodtodo/features/todo/model/todo.dart';

class TodoList extends BaseResponse{
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int userId;
  final List<Todo>? todos;

  TodoList({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    required this.userId,
    this.todos
  });

  factory TodoList.fromJson(Map<String, dynamic> json) {
    return TodoList(
      id: json['id'],
      title: json['title'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      userId: json['userId'],
      todos: json['todos'] != null ? List<Todo>.from(json['todos'].map((x) => Todo.fromJson(x))) : null
    );
  }
}