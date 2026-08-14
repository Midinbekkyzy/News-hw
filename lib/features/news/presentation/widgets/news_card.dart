import 'package:flutter/material.dart';
import 'package:news_hw/features/news/domain/models/news_article_model.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  final NewsArticleModel article;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: article.urlToImage.isEmpty
                  ? Container(
                      color: const Color(0xFFE3E5EA),
                      child: const Center(
                        child: Icon(Icons.image_not_supported_outlined),
                      ),
                    )
                  : Image.network(
                      article.urlToImage,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) {
                        return Container(
                          color: const Color(0xFFE3E5EA),
                          child: const Center(
                            child: Icon(Icons.image_not_supported_outlined),
                          ),
                        );
                      },
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            article.author.isEmpty ? 'Unknown' : article.author,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF8A8A8A),
            ),
          ),
        ],
      ),
    );
  }
}
