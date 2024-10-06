import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpodtodo/core/utils/storage_manager.dart';
import 'package:riverpodtodo/core/utils/token_helper.dart';

part 'token_helper_provider.g.dart';

@riverpod
TokenHelper tokenHelper(TokenHelperRef ref) {
  return TokenHelper(storageManager: StorageManager.instance);
}