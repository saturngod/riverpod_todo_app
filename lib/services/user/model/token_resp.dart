import 'package:riverpodtodo/core/network/base_response.dart';

class TokenResp extends BaseResponse {
  final String accessToken;
  final String refreshToken;
  final bool success;

  TokenResp({
    required this.accessToken,
    required this.refreshToken,
    required this.success,
  });

  factory TokenResp.fromJson(Map<String, dynamic> json) {
    return TokenResp(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      success: json['success'] ?? false,
    );
  }
}