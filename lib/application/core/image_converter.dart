import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageConverter {
  static Future<File> getImage({required String url}) async {
    /// Get Image from server
    final Response res = await Dio().get<List<int>>(
      url,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    /// Get App local storage
    final Directory appDir = await getApplicationDocumentsDirectory();

    /// Generate Image Name
    final String imageName = url.split('/').last;

    /// Create Empty File in app dir & fill with new image
    final File file = File(join(appDir.path, imageName));

    file.writeAsBytesSync(res.data as List<int>);

    return file;
  }
}
