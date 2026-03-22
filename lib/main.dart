import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/theme.dart';
import 'package:news_intelligence_app/features/auth/presentation/screens/login_screen.dart';
import 'package:news_intelligence_app/features/news/presentation/screens/news_screen.dart';
import 'package:news_intelligence_app/features/auth/presentation/providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  runApp(
    const ProviderScope(
      child: NewsIntelligenceApp(),
    ),
  );
}

class NewsIntelligenceApp extends ConsumerWidget {
  const NewsIntelligenceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'News Intelligence',
          debugShowCheckedModeBanner: false,
          theme: QuickWorkerAppTheme.themeLight,
          themeMode: ThemeMode.light,
          builder: (context, widget) {
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            double constrainedWidth = screenWidth;
            double constrainedHeight = screenHeight;

            if (screenWidth >= 320 && screenWidth <= 440) {
              constrainedWidth = screenWidth.clamp(320.0, 440.0);
              constrainedHeight = screenHeight.clamp(568.0, 956.0);
            } else if (screenWidth >= 744 && screenWidth <= 1024) {
              constrainedWidth = screenWidth.clamp(744.0, 1024.0);
              constrainedHeight = screenHeight.clamp(1133.0, 1440.0);
            }

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                size: Size(constrainedWidth, constrainedHeight),
              ),
              child: widget ?? const SizedBox.shrink(),
            );
          },
          home: authState.isAuthenticated
              ? const NewsScreen()
              : authState.isUnauthenticated || authState.isError
                  ? const LoginScreen()
                  : const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    ),
        );
      },
    );
  }
}
