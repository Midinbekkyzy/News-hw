import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/core/router/app_router.gr.dart';
import 'package:news_hw/core/service/storage_service/secure_storage_service.dart';
import 'package:news_hw/core/service/storage_service/shared_preferences_service.dart';

@RoutePage()
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
      await context.router.replaceAll([const OnboardingRoute()]);
      return;
    }

    final token = await getIt<SecureStorageService>().get(
      SecureStorageKeys.accessTokenKey,
    );

    if (!mounted) {
      return;
    }

    if (token != null && token.isNotEmpty) {
      await context.router.replaceAll([const MainRoute()]);
      return;
    }

    await context.router.replaceAll([const AuthRoute()]);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox.expand(),
    );
  }
}
