abstract class BaseRequest {
  BaseRequest();

  Map<String, dynamic> toJson() {
    throw UnimplementedError('BaseResponse.fromJson() must be implemented in subclasses');
  }
}