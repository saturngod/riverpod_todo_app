import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/network/api_route.dart';
import 'package:riverpodtodo/network/api_service.dart';

part 'todo_api.g.dart';

@riverpod
ApiService apiService(ApiServiceRef ref) {
  return ApiService(ApiRoute.baseUrl);
}