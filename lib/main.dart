import 'package:clean_api/clean_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_seller/presentation/auth/sign_in.dart';

import 'firebase_options.dart';
import 'presentation/widget_for_all/color.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  CleanApi.instance
      .setup(baseUrl: "https://test.incevio.cloud/api/vendor/", showLogs: true);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(primaryColor: MyColor.appbarColor),
          debugShowCheckedModeBanner: false,
          title: 'Multivendor App',
          home: const SignInPage(),
        );
      },
    );
  }
}
