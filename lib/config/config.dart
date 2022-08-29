import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zcart_vendor/helper/get_color_from.hex.dart';

class MyConfig {
  ///
  ///
  ///  [Read all the instructions carefully before editing any of the below]
  ///
  ///

  /// APP NAME
  ///This is your app name. You must change this name as your own app name. Currently the app name is
  /// [zCart].
  ///
  static const String appName = "zCart Vendor";

  ///

  /// APP URLS
  /// This is your app url. You must change this url as your own app url. Currently the app url is
  /// [https://zcart.incevio.com].
  ///
  static const String appUrl = "https://zcart.incevio.com";

  ///

  ///App API URL
  ///This is your app api url. You must change this url as your own app api url. Currently the app api
  ///url is [https://test.incevio.com/api/]. This is the url that you will use to access the api. Don't ////forget the slash [/] at the end and [https://] at the front.
  ///
  static const String appApiUrl = 'https://test.incevio.cloud/api/';

  ///

  /// APP COLORS
  /// These are your app colors. You must change this colors as your own app colors.
  ///Only change the hex values of the colors. Format of the color is [#FFFFFF].
  ///
  static final Color primaryColor = HexColor("#DF3030");
  static final Color accentColor = HexColor("#F5F5F5");

  ///App Gradient Colors
  static final Color gradientColor1 = HexColor("#B12704");
  static final Color gradientColor2 = HexColor("#F7CE19");

  ///

  /// APP LOADING INDICATOR [OPTIONAL]
  /// This is your app loading indicator. You must change this loading indicator as your own app.
  /// Currently the app loading indicator is [SpinKitCubeGrid].
  /// You will find all the loading indicators in [SpinKit] package - [https://pub.dev/packages/flutter_spinkit]
  /// You just need to add the name of the indicator after [SpinKit]. For example here the name of the
  /// indicator is [CubeGrid]. So the complete name of the indicator is [SpinKitCubeGrid].
  ///
  static Widget loadingIndicator({
    required Color color,
    required Duration duration,
    required double size,
  }) =>
      SpinKitCubeGrid(color: color, size: size, duration: duration);

  ///
  ///
  ///
  ///
  ///
  ///
  /// Dont change the code below
  MyConfig._();
}
