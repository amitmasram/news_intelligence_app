import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/themes/custom_text_theme.dart';

import 'package:news_intelligence_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_intelligence_app/features/news/presentation/providers/news_state.dart';
import 'package:news_intelligence_app/features/news/presentation/screens/article_detail_screen.dart';
import 'package:news_intelligence_app/features/news/presentation/widgets/article_card.dart';

class NewsFeedScreen extends ConsumerStatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  ConsumerState<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends ConsumerState<NewsFeedScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  final List<String> _categories = [
    'general',
    'business',
    'entertainment',
    'health',
    'science',
    'sports',
    'technology',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsNotifierProvider.notifier).fetchNews(category: _categories[0]);
    });
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      ref.read(newsNotifierProvider.notifier).fetchNews(category: _categories[_tabController.index]);
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      ref.read(newsNotifierProvider.notifier).fetchMoreNews();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title:  Text('News Intelligence',style: context.heading2BoldMedium,),

        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.map((c) => Tab(text: c.toUpperCase())).toList(),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.read(newsNotifierProvider.notifier).fetchNews(isRefresh: true),
        child: _buildBody(newsState),
      ),
    );
  }

  Widget _buildBody(NewsState state) {
    if (state is NewsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NewsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: () => ref.read(newsNotifierProvider.notifier).fetchNews(isRefresh: true),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    } else if (state is NewsLoaded) {
      if (state.articles.isEmpty) {
        return const Center(child: Text('No articles found'));
      }
      return ListView.builder(
        controller: _scrollController,
        itemCount: state.articles.length + (state.hasReachedMax ? 0 : 1),
        itemBuilder: (context, index) {
          if (index >= state.articles.length) {
            return const Center(child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ));
          }
          final article = state.articles[index];
          return ArticleCard(
            article: article,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailScreen(article: article),
                ),
              );
            },
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
