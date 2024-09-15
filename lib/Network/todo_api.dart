import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/Network/api_route.dart';
import 'package:riverpodtodo/Network/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ApiRoute.baseUrl);
});
