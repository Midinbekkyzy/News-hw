import 'package:flutter/material.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/presentation/adapter/news_paging_adapter.dart';
import 'package:news_hw/features/news/presentation/news_detail_page.dart';
import 'package:news_hw/features/news/presentation/widgets/everything_news_card.dart';
import 'package:paging_view/paging_view.dart';

class EveryThingPage extends StatefulWidget {
  const EveryThingPage({super.key});

  @override
  State<EveryThingPage> createState() => _EveryThingPageState();
}

class _EveryThingPageState extends State<EveryThingPage> {
  late final NewsPagingAdapter pagingAdapter;

  @override
  void initState() {
    pagingAdapter = getIt<NewsPagingAdapter>();
    super.initState();
  }

  @override
  void dispose() {
    pagingAdapter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          onRefresh: () async {
            pagingAdapter.refresh();
          },
          child: PagingList<int, NewsArticleModel>.separated(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 130),
            dataSource: pagingAdapter,
            initialLoadingWidget: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
            emptyWidget: const Center(child: Text('Нет Данных')),
            separatorBuilder: (_, _) {
              return const SizedBox(height: 12);
            },
            appendLoadingWidget: const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            errorBuilder: (_, error) {
              return Center(child: Text(error.toString()));
            },
            builder: (context, newsEntity, index) {
              return EverythingNewsCard(
                article: newsEntity,
                onTap: () => _openDetails(context, newsEntity),
              );
            },
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, NewsArticleModel article) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => NewsDetailPage(article: article),
      ),
    );
  }
}
