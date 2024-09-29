import 'package:riverpodtodo/Network/base_request.dart';

class TodoListCreateRequest extends BaseRequest{
  final String title;

  TodoListCreateRequest({required this.title});
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
    };
  }
}