import 'package:clean_api/clean_api.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:zcart_seller/application/core/config.dart';
import 'package:zcart_seller/application/core/shared_prefs.dart';
import 'package:zcart_seller/infrastructure/app/constants.dart';
import 'package:zcart_seller/infrastructure/app/notification/notification_model.dart';
import 'package:zcart_seller/presentation/auth/sign_in_page.dart';

Future<void> _firebaseMessegingBackgroundHandler(RemoteMessage message) async {
  Logger.i('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessegingBackgroundHandler);

  CleanApi.instance.setup(baseUrl: '$apiEndpoint/', showLogs: true);

  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [Locale('en'), Locale('bn')],
        fallbackLocale: const Locale('en'),
        // assetLoader: codegen,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    requestPermission();
    initInfo();
    getToken();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        Logger.i('messege: ${message.messageId}');

        BigTextStyleInformation bigTextStyleInformation =
            BigTextStyleInformation(
          message.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: message.notification!.title.toString(),
          htmlFormatContentTitle: true,
        );

        AndroidNotificationDetails androidPlatformChannelSpecifics =
            AndroidNotificationDetails(
          'zcart',
          'zcart',
          importance: Importance.high,
          styleInformation: bigTextStyleInformation,
          priority: Priority.high,
          playSound: true,
        );

        // Save notifications to shared prefs
        SharedPref.saveNotifications(
            messages: NotificationModel(
          title: message.notification!.title ?? '',
          description: message.notification!.body ?? '',
        ));

        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);
        await flutterLocalNotificationsPlugin.show(
          0,
          message.notification!.title,
          message.notification!.body,
          platformChannelSpecifics,
          payload: message.data['title'],
        );
      },
    );

    super.initState();
  }

  void requestPermission() async {
    FirebaseMessaging messeging = FirebaseMessaging.instance;

    NotificationSettings settings = await messeging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      Logger.i('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      Logger.i('User granted provisional permission');
    } else {
      Logger.i('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance
        .getToken()
        .then((value) => Logger.i(value));
  }

  void initInfo() {
    var androidInitialize =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iOSInitialize = const IOSini();
    var initializationsSettings =
        InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings,
        onSelectNotification: ((payload) {}));
  }

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
