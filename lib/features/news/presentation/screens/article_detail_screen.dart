import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:news_intelligence_app/core/constants/uiconfigs/themes/custom_text_theme.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';
import 'package:news_intelligence_app/features/news/presentation/providers/favorites_provider.dart';

class ArticleDetailScreen extends ConsumerWidget {
  final Article article;

  const ArticleDetailScreen({super.key, required this.article});

  /// Launch the article URL in an external application
  Future<void> _launchUrl(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $url')),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error launching article: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesNotifierProvider);
    final isFavorite = favorites.any((a) => a.url == article.url);

    return Scaffold(
      appBar: AppBar(
        title: Text('Article Detail',style: context.heading2BoldMedium,),
        actions: [
          // Favorite toggle button
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              ref.read(favoritesNotifierProvider.notifier).toggleFavorite(article);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article header image
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  color: Colors.grey[200],
                  child: const Icon(Icons.broken_image),
                ),
              ),

            // Article content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Article title
                  Text(
                    article.title,
                    style: context.heading2BoldMedium,
                  ),
                  const SizedBox(height: 8),

                  // Author and publishing date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          article.author,
                          style: context.body2RegularSmall.copyWith(
                            color: Colors.grey[600],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(article.publishedAt),
                        style: context.body2RegularSmall.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Article description/summary
                  Text(
                    article.description,
                    style: context.body1MediumLarge,
                  ),
                  const SizedBox(height: 16),

                  // Full article content
                  Text(
                    article.content,
                    style: context.body1RegularLarge.copyWith(
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // External link button
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _launchUrl(context, article.url),
                      child: const Text('Read Full Article'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Formats the publication date to a human-readable format
  String _formatDate(String dateStr) {
    try {
      final dateTime = DateTime.parse(dateStr);
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } catch (e) {
      return dateStr;
    }
  }
}
