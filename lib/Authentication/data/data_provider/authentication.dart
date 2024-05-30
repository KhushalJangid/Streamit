import 'package:dio/dio.dart';

const String baseUrl = 'http://192.168.43.230:8000';
const timeLimit = Duration(seconds: 5);

class UserApi {
  final CancelToken cancelToken;
  final Dio dio;
  final String url = "";
  UserApi()
      : cancelToken = CancelToken(),
        dio = Dio();

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(url,
          data: {
            "email": email,
            "password": password,
          },
          cancelToken: cancelToken,
          options: Options());
      return true;
    } catch (e) {
      print(e);
      throw Error();
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      final response = await dio.get(url, cancelToken: cancelToken);
      return true;
    } catch (e) {
      print(e);
      throw Error();
    }
  }
}
