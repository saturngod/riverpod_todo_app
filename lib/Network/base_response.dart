abstract class BaseResponse {
  BaseResponse();

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    throw UnimplementedError('BaseResponse.fromJson() must be implemented in subclasses');
  }
}