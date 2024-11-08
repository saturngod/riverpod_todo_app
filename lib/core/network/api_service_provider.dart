import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/network/api_route.dart';
import 'package:riverpodtodo/core/network/api_service.dart';

part 'api_service_provider.g.dart';

@Riverpod(keepAlive: true)
ApiService apiService(Ref ref) {
  return ApiService(ApiRoute.baseUrl);
}