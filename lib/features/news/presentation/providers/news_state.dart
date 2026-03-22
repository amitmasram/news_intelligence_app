import 'package:equatable/equatable.dart';
import 'package:news_intelligence_app/features/news/domain/entities/article.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  const factory NewsState.initial() = NewsInitial;
  const factory NewsState.loading() = NewsLoading;
  const factory NewsState.loaded({
    required List<Article> articles,
    required bool hasReachedMax,
  }) = NewsLoaded;
  const factory NewsState.error(String message) = NewsError;

  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  final List<Article> articles;
  final bool hasReachedMax;

  const NewsLoaded({
    required this.articles,
    required this.hasReachedMax,
  });

  NewsLoaded copyWith({
    List<Article>? articles,
    bool? hasReachedMax,
  }) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [articles, hasReachedMax];
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
