import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/features/main/presentation/bloc/main_bloc.dart';
import 'package:news_hw/features/main/presentation/widgets/app_bottom_navigation.dart';
import 'package:news_hw/features/news/presentation/everything_page.dart';
import 'package:news_hw/features/news/presentation/news_page.dart';
import 'package:news_hw/features/profile/presentation/profile_page.dart';

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const _pages = [NewsPage(), EveryThingPage(), ProfilePage()];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (_) =>
          getIt<MainBloc>()..add(CheckNotificationPermissionEvent()),
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: AppBottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
