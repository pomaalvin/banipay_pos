import 'package:banipay_pos/domain/auth_controller.dart';
import 'package:banipay_pos/firebase_options.dart';
import 'package:banipay_pos/ui/pages/general_loading.dart';
import 'package:banipay_pos/ui/values/routes.dart';
import 'package:banipay_pos/ui/values/routes_keys.dart';
import 'package:banipay_pos/ui/values/theme_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Get.put<AuthController>(AuthController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BaniPay',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('es'),
      ],
      theme: ThemeConfig.config(),
      builder: (context, widget) {
        if (widget != null) {
          return widget;
        }
        return const GeneralLoading();
      },
      getPages: Routes.routes(),
      initialRoute: RoutesKeys.splashLink,
    );
  }
}
