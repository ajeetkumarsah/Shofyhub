import 'dart:convert';

import 'package:clean_api/clean_api.dart';
import 'package:http/http.dart' as http;
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/domain/app/plugin/i_plugin_repo.dart';

class PluginRepo extends IPluginRepo {
  final cleanApi = CleanApi.instance;

  @override
  Future<bool> checkPlugin({required String slug}) async {
    final response = await http.get(Uri.parse('$apiEndpoint/plugin/$slug'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['data'];
    } else {
      return false;
    }
  }
}
