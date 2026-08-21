import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/features/splash/presentation/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
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
