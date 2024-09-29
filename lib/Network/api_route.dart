class ApiRoute {
  static const String baseUrl = 'http://10.0.2.2:3000/api';
  static const String refreshToken = '/token/refresh';
  static const String login = '/users/login';
  static const String register = '/users/register';

  static const String list = "/lists";
  static String listWithId(String id) {
    return "/lists/$id";
  }
  static const String todo = "/todos";

  static String todoWithId(String id) {
    return "/todos/$id";
  }
}