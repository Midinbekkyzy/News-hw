import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/core/service/firebase_service/push_backround_handler.dart';
import 'package:news_hw/core/service/firebase_service/push_foreground_service.dart';
import 'package:news_hw/features/splash/presentation/splash_page.dart';
import 'package:news_hw/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  await setupServiceLocator();

  if (!kIsWeb) {
    await getIt<PushForegroundService>().initialize();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF232323),
          brightness: Brightness.light,
          surface: Colors.white,
        ),
      ),
      home: const SplashPage(),
    );
  }
}
