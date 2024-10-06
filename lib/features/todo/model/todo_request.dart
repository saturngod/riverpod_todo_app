import 'package:riverpodtodo/core/network/base_request.dart';

class TodoUpdateRequest extends BaseRequest {
  
  final String title;
  
  final bool completed;

  TodoUpdateRequest({
    required this.title,
    required this.completed,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'completed': completed,
    };
  }
}