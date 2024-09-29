import 'package:riverpodtodo/network/base_response.dart';

class RegisterResp extends BaseResponse {

  final bool success;

  RegisterResp({
    required this.success,
  });

  factory RegisterResp.fromJson(Map<String, dynamic> json) {
    return RegisterResp(
      success: json['success'] ?? false,
    );
  }
}