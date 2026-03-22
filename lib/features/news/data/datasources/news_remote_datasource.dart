import 'package:dio/dio.dart';
import 'package:news_intelligence_app/core/constants/api_constants.dart';
import 'package:news_intelligence_app/core/error/exceptions.dart';
import 'package:news_intelligence_app/features/news/data/model/article_model.dart';

abstract class NewsRemoteDataSource {
  Future<List<ArticleModel>> getTopHeadlines({
    required String category,
    required int page,
    required String apiKey,
  });

  Future<List<ArticleModel>> searchNews({
    required String query,
    required int page,
    required String apiKey,
  });
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final Dio dio;

  NewsRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<ArticleModel>> getTopHeadlines({
    required String category,
    required int page,
    required String apiKey,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.topHeadlines,
        queryParameters: {
          'category': category,
          'country': ApiConstants.defaultCountry,
          'page': page,
          'pageSize': ApiConstants.defaultPageSize,
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'];
        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<ArticleModel>> searchNews({
    required String query,
    required int page,
    required String apiKey,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.everything,
        queryParameters: {
          'q': query,
          'page': page,
          'pageSize': ApiConstants.defaultPageSize,
          'apiKey': apiKey,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> articlesJson = response.data['articles'];
        return articlesJson.map((json) => ArticleModel.fromJson(json)).toList();
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
