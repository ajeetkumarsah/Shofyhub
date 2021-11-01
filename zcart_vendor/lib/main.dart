import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zcart_vendor/config/config.dart';
import 'package:zcart_vendor/helper/constants.dart';
import 'package:zcart_vendor/views/dashboard/dashboard_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    //
    //THEME
    final _themeData = ThemeData(
      appBarTheme: AppBarTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(defaultRadius),
            bottomRight: Radius.circular(defaultRadius),
          ),
        ),
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.headline6,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: GoogleFonts.poppinsTextTheme(
        Theme.of(context).textTheme,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 0,
        textStyle: GoogleFonts.poppins(
          textStyle: Theme.of(context).textTheme.subtitle2,
          fontWeight: FontWeight.bold,
        ),
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultRadius),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultRadius),
        ),
      )),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          textStyle: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.red,
                ),
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultRadius),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: GoogleFonts.poppins(
            textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: Colors.red,
                ),
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding, vertical: defaultRadius),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultRadius),
          ),
        ),
      ),
    );

    //

    return MaterialApp(
      title: MyConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: const DashboardPage(),
    );
  }
}
