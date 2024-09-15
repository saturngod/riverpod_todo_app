import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpodtodo/Utils/token_helper.dart';
import 'package:riverpodtodo/splash/model/auth_model.dart';

final authModelProvider = FutureProvider.autoDispose<AuthModel>((ref) async {
  final tokenHelper = TokenHelper();
  return AuthModel(tokenHelper, ref);
});