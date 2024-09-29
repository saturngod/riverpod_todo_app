import 'package:riverpodtodo/network/base_request.dart';

class TodoCreateRequest extends BaseRequest{
  final String title;
  final int listId;

  TodoCreateRequest({required this.title, required this.listId});

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'listId': listId,
    };
  }
}