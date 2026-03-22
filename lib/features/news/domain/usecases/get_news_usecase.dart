import 'package:dartz/dartz.dart';
import 'package:news_intelligence_app/core/error/failures.dart';
import 'package:news_intelligence_app/core/usecase/usecase.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';
import 'package:news_intelligence_app/features/news/domain/repositories/news_repository.dart';

class GetNewsUseCase implements UseCase<List<Article>, GetNewsParams> {
  final NewsRepository repository;

  GetNewsUseCase(this.repository);

  @override
  Future<Either<Failure, List<Article>>> call(GetNewsParams params) async {
    return await repository.getTopHeadlines(
      category: params.category,
      page: params.page,
    );
  }
}

class GetNewsParams {
  final String category;
  final int page;

  GetNewsParams({required this.category, required this.page});
}
