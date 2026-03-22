import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_intelligence_app/features/news/data/datasources/favorites_local_datasource.dart';
import 'package:news_intelligence_app/features/news/data/model/article_model.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';

final favoritesBoxProvider = Provider<Box<String>>((ref) => Hive.box<String>('favoritesBox'));

final favoritesLocalDataSourceProvider = Provider<FavoritesLocalDataSource>((ref) {
  return FavoritesLocalDataSourceImpl(box: ref.watch(favoritesBoxProvider));
});

final favoritesNotifierProvider =
    NotifierProvider<FavoritesNotifier, List<Article>>(() {
  return FavoritesNotifier();
});

class FavoritesNotifier extends Notifier<List<Article>> {
  late final FavoritesLocalDataSource localDataSource;

  @override
  List<Article> build() {
    localDataSource = ref.watch(favoritesLocalDataSourceProvider);
    return localDataSource.getFavorites();
  }

  Future<void> toggleFavorite(Article article) async {
    final articleModel = ArticleModel(
      title: article.title,
      author: article.author,
      description: article.description,
      url: article.url,
      urlToImage: article.urlToImage,
      publishedAt: article.publishedAt,
      content: article.content,
    );

    if (localDataSource.isFavorite(article.url)) {
      print('Article is favorite, removing...');
      await localDataSource.removeArticle(article.url);
    } else {
      print('Article is not favorite, saving...');
      await localDataSource.saveArticle(articleModel);
    }
    state = localDataSource.getFavorites();
    print('New favorites count: ${state.length}');
  }

  bool isFavorite(String url) {
    return localDataSource.isFavorite(url);
  }
}
