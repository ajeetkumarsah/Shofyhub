import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/presentation/auth/sign_in_page.dart';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  CleanApi.instance.setup(baseUrl: '$apiEndpoint/', showLogs: true);
  runApp(ProviderScope(
      child: EasyLocalization(
          path: 'assets/translations',
          supportedLocales: const [Locale('en'), Locale('bn')],
          fallbackLocale: const Locale('en'),
          // assetLoader: codegen,
          child: const MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: Constants.primaryColor),
                ),
                primaryColor: Constants.primaryColor,
                tabBarTheme: const TabBarTheme(
                  // indicatorSize: TabBarIndicatorSize.tab,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(color: Constants.primaryColor, width: 3),
                  ),
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Constants.appbarColor,
                )),
            debugShowCheckedModeBanner: false,
            title: 'Multivendor App',
            home: const SignInPage(),
          );
        },
      ),
    );
  }
}
