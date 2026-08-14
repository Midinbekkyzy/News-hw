import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_hw/core/di/service_locator.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';
import 'package:news_hw/features/news/presentation/bloc/news_bloc.dart';
import 'package:news_hw/features/news/presentation/news_detail_page.dart';
import 'package:news_hw/features/news/presentation/widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewsBloc>()..add(GetNewsEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Text(
                  'My favourites',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              Expanded(
                child: BlocBuilder<NewsBloc, NewsState>(
                  builder: (context, state) {
                    if (state is LoadedNewsState) {
                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: state.news.length,
                        itemBuilder: (context, index) {
                          final NewsArticleModel article = state.news[index];
                          return NewsCard(
                            article: article,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      NewsDetailPage(article: article),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    if (state is ErrorNewsState) {
                      return Center(child: Text(state.message));
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
      ),
    );
  }
}
