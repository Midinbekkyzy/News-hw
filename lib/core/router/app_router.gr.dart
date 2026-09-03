// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:news_hw/features/auth/presentation/auth_page.dart' as _i1;
import 'package:news_hw/features/main/presentation/main_page.dart' as _i3;
import 'package:news_hw/features/news/domain/models/news_article_model.dart'
    as _i11;
import 'package:news_hw/features/news/presentation/everything_page.dart' as _i2;
import 'package:news_hw/features/news/presentation/news_detail_page.dart'
    as _i4;
import 'package:news_hw/features/news/presentation/news_page.dart' as _i5;
import 'package:news_hw/features/onboarding/presentation/onboarding_page.dart'
    as _i6;
import 'package:news_hw/features/profile/presentation/profile_page.dart' as _i7;
import 'package:news_hw/features/splash/presentation/splash_page.dart' as _i8;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i9.PageRouteInfo<void> {
  const AuthRoute({List<_i9.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthPage();
    },
  );
}

/// generated route for
/// [_i2.EveryThingPage]
class EveryThingRoute extends _i9.PageRouteInfo<void> {
  const EveryThingRoute({List<_i9.PageRouteInfo>? children})
    : super(EveryThingRoute.name, initialChildren: children);

  static const String name = 'EveryThingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.EveryThingPage();
    },
  );
}

/// generated route for
/// [_i3.MainPage]
class MainRoute extends _i9.PageRouteInfo<void> {
  const MainRoute({List<_i9.PageRouteInfo>? children})
    : super(MainRoute.name, initialChildren: children);

  static const String name = 'MainRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainPage();
    },
  );
}

/// generated route for
/// [_i4.NewsDetailPage]
class NewsDetailRoute extends _i9.PageRouteInfo<NewsDetailRouteArgs> {
  NewsDetailRoute({
    _i10.Key? key,
    required _i11.NewsArticleModel article,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         NewsDetailRoute.name,
         args: NewsDetailRouteArgs(key: key, article: article),
         initialChildren: children,
       );

  static const String name = 'NewsDetailRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NewsDetailRouteArgs>();
      return _i4.NewsDetailPage(key: args.key, article: args.article);
    },
  );
}

class NewsDetailRouteArgs {
  const NewsDetailRouteArgs({this.key, required this.article});

  final _i10.Key? key;

  final _i11.NewsArticleModel article;

  @override
  String toString() {
    return 'NewsDetailRouteArgs{key: $key, article: $article}';
  }
}

/// generated route for
/// [_i5.NewsPage]
class NewsRoute extends _i9.PageRouteInfo<void> {
  const NewsRoute({List<_i9.PageRouteInfo>? children})
    : super(NewsRoute.name, initialChildren: children);

  static const String name = 'NewsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.NewsPage();
    },
  );
}

/// generated route for
/// [_i6.OnboardingPage]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.OnboardingPage();
    },
  );
}

/// generated route for
/// [_i7.ProfilePage]
class ProfileRoute extends _i9.PageRouteInfo<void> {
  const ProfileRoute({List<_i9.PageRouteInfo>? children})
    : super(ProfileRoute.name, initialChildren: children);

  static const String name = 'ProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProfilePage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashPage();
    },
  );
}
