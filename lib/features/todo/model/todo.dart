import 'package:riverpodtodo/core/network/base_response.dart';

class Todo extends BaseResponse {
  final int id;
  final String title;
  final bool completed;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int listId;

  Todo({
    required this.id,
    required this.title,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
    required this.listId,
  });
  

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      listId: json['listId'],
    );
  }

 
}