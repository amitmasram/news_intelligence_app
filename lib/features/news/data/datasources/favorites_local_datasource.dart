import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_intelligence_app/features/news/data/model/article_model.dart';

abstract class FavoritesLocalDataSource {
  Future<void> saveArticle(ArticleModel article);
  Future<void> removeArticle(String url);
  List<ArticleModel> getFavorites();
  bool isFavorite(String url);
}

class FavoritesLocalDataSourceImpl implements FavoritesLocalDataSource {
  final Box<String> box;

  FavoritesLocalDataSourceImpl({required this.box});

  @override
  Future<void> saveArticle(ArticleModel article) async {
    print('Saving article: ${article.title}');
    await box.put(article.url, jsonEncode(article.toJson()));
    print('Article saved successfully');
  }

  @override
  Future<void> removeArticle(String url) async {
    print('Removing article: $url');
    await box.delete(url);
    print('Article removed successfully');
  }

  @override
  List<ArticleModel> getFavorites() {
    return box.values
        .map((jsonStr) => ArticleModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  @override
  bool isFavorite(String url) {
    return box.containsKey(url);
  }
}
