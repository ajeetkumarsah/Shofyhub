import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:alpesportif_seller/application/core/config.dart';

class DioClient {
  static Future<BaseOptions> getBasseOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    BaseOptions options = BaseOptions(
      connectTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
      followRedirects: false,
      validateStatus: (status) {
        return status! < 500;
      },
      baseUrl: apiEndpoint,
      headers: {
        "Authorization": 'Bearer ${prefs.getString('token')}',
        "Accept": "application/json",
        'Content-type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      },
    );
    return options;
  }

  static Future<dynamic> get({url}) async {
    var dio = Dio(await getBasseOptions());
    var response = await dio.get(url);
    return response;
  }

  static Future<dynamic> post({url, payload}) async {
    var dio = Dio(await getBasseOptions());
    var response = await dio.post(url, data: payload);
    return response;
  }

  static Future<dynamic> put({url, payload}) async {
    var dio = Dio(await getBasseOptions());
    var response = await dio.put(url, data: payload);
    return response;
  }
}
