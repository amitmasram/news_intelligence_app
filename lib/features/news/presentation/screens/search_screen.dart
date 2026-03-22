import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_intelligence_app/features/news/presentation/providers/news_provider.dart';
import 'package:news_intelligence_app/features/news/presentation/providers/news_state.dart';
import 'package:news_intelligence_app/features/news/presentation/screens/article_detail_screen.dart';
import 'package:news_intelligence_app/features/news/presentation/widgets/article_card.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        ref.read(newsNotifierProvider.notifier).searchNews(query);
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final newsState = ref.watch(newsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search news...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
          onChanged: _onSearchChanged,
        ),
      ),
      body: _buildBody(newsState),
    );
  }

  Widget _buildBody(NewsState state) {
    if (state is NewsInitial) {
      return const Center(child: Text('Enter a query to search'));
    } else if (state is NewsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NewsError) {
      return Center(child: Text(state.message));
    } else if (state is NewsLoaded) {
      if (state.articles.isEmpty) {
        return const Center(child: Text('No articles found'));
      }
      return ListView.builder(
        itemCount: state.articles.length,
        itemBuilder: (context, index) {
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
