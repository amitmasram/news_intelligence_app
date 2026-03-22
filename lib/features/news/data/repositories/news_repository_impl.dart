import 'package:dartz/dartz.dart';
import 'package:news_intelligence_app/core/error/exceptions.dart';
import 'package:news_intelligence_app/core/error/failures.dart';
import 'package:news_intelligence_app/core/secrets/app_secrets.dart';
import 'package:news_intelligence_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';
import 'package:news_intelligence_app/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final AppSecrets appSecrets;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.appSecrets,
  });

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines({
    required String category,
    required int page,
  }) async {
    try {
      final remoteArticles = await remoteDataSource.getTopHeadlines(
        category: category,
        page: page,
        apiKey: appSecrets.newsApiKey,
      );
      return Right(remoteArticles);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Article>>> searchNews({
    required String query,
    required int page,
  }) async {
    try {
      final remoteArticles = await remoteDataSource.searchNews(
        query: query,
        page: page,
        apiKey: appSecrets.newsApiKey,
      );
      return Right(remoteArticles);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? 'Server error'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
