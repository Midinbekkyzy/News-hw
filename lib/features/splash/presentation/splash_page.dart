import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/core/service/storage_service/secure_storage_service.dart';
import 'package:news_hw/core/service/storage_service/shared_preferences_service.dart';
import 'package:news_hw/features/auth/presentation/auth_page.dart';
import 'package:news_hw/features/news/presentation/news_page.dart';
import 'package:news_hw/features/onboarding/presentation/onboarding_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _openNextPage();
  }

  Future<void> _openNextPage() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (!mounted) {
      return;
    }

    final hasSeenOnboarding = getIt<SharedPreferencesService>().getBool(
      SharedPreferencesKeys.hasSeenOnboarding,
    );

    if (!hasSeenOnboarding) {
      _replace(const OnboardingPage());
      return;
    }

    final token = await getIt<SecureStorageService>().get(
      SecureStorageKeys.accessTokenKey,
    );

    if (!mounted) {
      return;
    }

    if (token != null && token.isNotEmpty) {
      _replace(const NewsPage());
      return;
    }

    _replace(const AuthPage());
  }

  void _replace(Widget page) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(),
    );
  }
}
