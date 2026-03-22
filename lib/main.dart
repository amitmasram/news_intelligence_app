import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/theme.dart';
import 'package:news_intelligence_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_intelligence_app/features/news/presentation/screens/news_screen.dart';
import 'package:news_intelligence_app/features/auth/presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  await Hive.openBox<String>('favoritesBox');

  runApp(
    const ProviderScope(
      child: NewsIntelligenceApp(),
    ),
  );
}

class NewsIntelligenceApp extends ConsumerWidget {
  const NewsIntelligenceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return MaterialApp(
      title: 'News Intelligence',
      debugShowCheckedModeBanner: false,
      theme: QuickWorkerAppTheme.themeLight,
      themeMode: ThemeMode.light,
      home: authState.isAuthenticated
          ? const NewsScreen()
          : authState.isUnauthenticated || authState.isError
              ? const LoginScreen()
              : const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                ),
    );
  }
}
