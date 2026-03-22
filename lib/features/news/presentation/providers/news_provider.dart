import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_intelligence_app/core/network/dio_client.dart';
import 'package:news_intelligence_app/core/secrets/app_secrets.dart';
import 'package:news_intelligence_app/features/news/data/datasources/news_remote_datasource.dart';
import 'package:news_intelligence_app/features/news/data/repositories/news_repository_impl.dart';
import 'package:news_intelligence_app/features/news/domain/repositories/news_repository.dart';
import 'package:news_intelligence_app/features/news/domain/usecases/get_news_usecase.dart';
import 'package:news_intelligence_app/features/news/domain/usecases/search_news_usecase.dart';
import 'package:news_intelligence_app/features/news/presentation/providers/news_state.dart';

final dioProvider = Provider((ref) => Dio());

final dioClientProvider = Provider((ref) => DioClient(ref.watch(dioProvider)));

final appSecretsProvider = Provider((ref) => AppSecrets());

final newsRemoteDataSourceProvider = Provider<NewsRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return NewsRemoteDataSourceImpl(dio: dioClient.dio);
});

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  return NewsRepositoryImpl(
    remoteDataSource: ref.watch(newsRemoteDataSourceProvider),
    appSecrets: ref.watch(appSecretsProvider),
  );
});

final getNewsUseCaseProvider = Provider((ref) {
  return GetNewsUseCase(ref.watch(newsRepositoryProvider));
});

final searchNewsUseCaseProvider = Provider((ref) {
  return SearchNewsUseCase(ref.watch(newsRepositoryProvider));
});

final newsNotifierProvider =
    NotifierProvider<NewsNotifier, NewsState>(() {
  return NewsNotifier();
});

class NewsNotifier extends Notifier<NewsState> {
  late final GetNewsUseCase getNewsUseCase;
  late final SearchNewsUseCase searchNewsUseCase;

  int _currentPage = 1;
  String _currentCategory = 'general';
  bool _isFetchingMore = false;

  @override
  NewsState build() {
    getNewsUseCase = ref.watch(getNewsUseCaseProvider);
    searchNewsUseCase = ref.watch(searchNewsUseCaseProvider);
    return const NewsState.initial();
  }

  Future<void> fetchNews({String? category, bool isRefresh = false}) async {
    if (category != null) {
      _currentCategory = category;
    }

    if (isRefresh) {
      _currentPage = 1;
      // We don't set state to loading here because RefreshIndicator shows its own spinner
    } else {
      _currentPage = 1;
      state = const NewsState.loading();
    }

    final result = await getNewsUseCase(
      GetNewsParams(category: _currentCategory, page: _currentPage),
    );

    result.fold(
      (failure) => state = NewsState.error(failure.message),
      (articles) {
        state = NewsState.loaded(articles: articles, hasReachedMax: articles.length < 20);
        _currentPage++;
      },
    );
  }

  Future<void> fetchMoreNews() async {
    if (_isFetchingMore || state is! NewsLoaded || (state as NewsLoaded).hasReachedMax) return;

    _isFetchingMore = true;
    final currentState = state as NewsLoaded;

    final result = await getNewsUseCase(
      GetNewsParams(category: _currentCategory, page: _currentPage),
    );

    result.fold(
      (failure) {
        _isFetchingMore = false;
      },
      (newArticles) {
        _isFetchingMore = false;
        if (newArticles.isEmpty) {
          state = currentState.copyWith(hasReachedMax: true);
        } else {
          state = NewsState.loaded(
            articles: currentState.articles + newArticles,
            hasReachedMax: newArticles.length < 20,
          );
          _currentPage++;
        }
      },
    );
  }

  Future<void> searchNews(String query) async {
    state = const NewsState.loading();
    _currentPage = 1;

    final result = await searchNewsUseCase(
      SearchNewsParams(query: query, page: _currentPage),
    );

    result.fold(
      (failure) => state = NewsState.error(failure.message),
      (articles) {
        state = NewsState.loaded(articles: articles, hasReachedMax: articles.length < 20);
        _currentPage++;
      },
    );
  }
}
