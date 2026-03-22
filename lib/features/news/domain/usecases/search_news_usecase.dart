import 'package:dartz/dartz.dart';
import 'package:news_intelligence_app/core/error/failures.dart';
import 'package:news_intelligence_app/core/usecase/usecase.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';
import 'package:news_intelligence_app/features/news/domain/repositories/news_repository.dart';

class SearchNewsUseCase implements UseCase<List<Article>, SearchNewsParams> {
  final NewsRepository repository;

  SearchNewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(SearchNewsParams params) async {
    return await repository.searchNews(
      query: params.query,
      page: params.page,
    );
  }
}

class SearchNewsParams {
  final String query;
  final int page;

  SearchNewsParams({required this.query, required this.page});
}
