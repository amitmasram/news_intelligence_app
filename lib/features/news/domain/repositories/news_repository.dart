import 'package:dartz/dartz.dart';
import 'package:news_intelligence_app/core/error/failures.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlines({
    required String category,
    required int page,
  });

  Future<Either<Failure, List<Article>>> searchNews({
    required String query,
    required int page,
  });
}
