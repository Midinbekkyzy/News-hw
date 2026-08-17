import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_hw/features/news/presentation/news_detail_page.dart';
import 'package:news_hw/features/news/presentation/widgets/news_search_field.dart';
import 'package:news_hw/features/news/presentation/widgets/news_section.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewsBloc>()..add(GetNewsEvent()),
      child: const _NewsView(),
    );
  }
}

class _NewsView extends StatelessWidget {
  const _NewsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 25, 30, 0),
              child: NewsSearchField(
                onSearch: (query) {
                  context.read<NewsBloc>().add(SearchNewsEvent(query: query));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<NewsBloc, NewsState>(
                builder: (context, state) {
                  if (state is LoadedNewsState) {
                    return _NewsContent(
                      news: state.news,
                      onArticleTap: (article) =>
                          _openDetails(context, article),
                    );
                  }
                  if (state is ErrorNewsState) {
                    return _ErrorContent(
                      onRetry: () =>
                          context.read<NewsBloc>().add(GetNewsEvent()),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, NewsArticleModel article) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 520),
        reverseTransitionDuration: const Duration(milliseconds: 420),
        pageBuilder: (_, _, _) => NewsDetailPage(article: article),
        transitionsBuilder: (_, animation, _, child) {
          final curvedAnimation = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
            reverseCurve: Curves.easeInCubic,
          );
          return FadeTransition(
            opacity: curvedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.08),
                end: Offset.zero,
              ).animate(curvedAnimation),
              child: child,
            ),
          );
        },
      ),
    );
  }
}

class _NewsContent extends StatelessWidget {
  const _NewsContent({
    required this.news,
    required this.onArticleTap,
  });

  final List<NewsArticleModel> news;
  final ValueChanged<NewsArticleModel> onArticleTap;

  @override
  Widget build(BuildContext context) {
    final sections = _splitIntoThree(news);

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 73, bottom: 28),
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi Jorge,',
                style: TextStyle(
                  color: Color(0xFF232323),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Let’s find something new...',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 37),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: NewsSection(
            title: 'Trending',
            articles: sections[0],
            featured: true,
            onArticleTap: onArticleTap,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: NewsSection(
            title: 'New releases',
            articles: sections[1],
            onArticleTap: onArticleTap,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: NewsSection(
            title: 'Selected for you',
            articles: sections[2],
            onArticleTap: onArticleTap,
          ),
        ),
      ],
    );
  }

  List<List<NewsArticleModel>> _splitIntoThree(
    List<NewsArticleModel> articles,
  ) {
    final result = List.generate(3, (_) => <NewsArticleModel>[]);
    if (articles.isEmpty) {
      return result;
    }
    final baseLength = articles.length ~/ result.length;
    final remainder = articles.length % result.length;
    var start = 0;

    for (var index = 0; index < result.length; index++) {
      final sectionLength = baseLength + (index < remainder ? 1 : 0);
      final end = start + sectionLength;
      result[index] = articles.sublist(start, end);
      start = end;
    }

    return result;
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Unable to load news',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF232323),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(onPressed: onRetry, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}
