import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:news_hw/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => defaultTargetPlatform == TargetPlatform.iOS
      ? const RouteType.cupertino()
      : const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: MainRoute.page),
        AutoRoute(page: NewsRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: EveryThingRoute.page),
        AutoRoute(page: NewsDetailRoute.page),
      ];
}
