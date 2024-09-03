import 'dart:convert';

import 'package:clean_api/clean_api.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:alpesportif_seller/application/core/config.dart';
import 'package:alpesportif_seller/domain/app/plugin/i_plugin_repo.dart';

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
