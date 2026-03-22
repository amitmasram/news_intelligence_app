import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_intelligence_app/core/constants/uiconfigs/theme.dart';
import 'package:news_intelligence_app/features/auth/presentation/screens/login_screen.dart';

void main() async {

  runApp(
   const NewsIntelligenceApp(),

  );
}

class NewsIntelligenceApp extends StatefulWidget {
  const NewsIntelligenceApp({Key? key}) : super(key: key);

  @override
  State<NewsIntelligenceApp> createState() => _NewsIntelligenceAppState();
}

class _NewsIntelligenceAppState extends State<NewsIntelligenceApp> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,

      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Quickworker',
          debugShowCheckedModeBanner: false,
          theme: QuickWorkerAppTheme.themeLight,
          themeMode: ThemeMode.light,
          //initialRoute: AppRoutes.onboarding,
          // home: BlocSelector<AppUserCubit, AppUserState, bool>(
          //   selector: (state) {
          //     return state is AppUserLoggedIn;
          //   },
          //   builder: (context, isLoggedIn) {
          //     if (isLoggedIn) {
          //       return BlogPage();
          //     }
          //     return LoginPhonePage();
          //   },
          // ),
         // routes: AppRoutes.routes,
          builder: (context, widget) {
            // Get screen dimensions
            final screenWidth = MediaQuery.of(context).size.width;
            final screenHeight = MediaQuery.of(context).size.height;

            // Determine device type and apply constraints
            double constrainedWidth = screenWidth;
            double constrainedHeight = screenHeight;

            // Mobile Portrait constraints (320-440px width, 568-956px height)
            if (screenWidth >= 320 && screenWidth <= 440) {
              constrainedWidth = screenWidth.clamp(320.0, 440.0);
              constrainedHeight = screenHeight.clamp(568.0, 956.0);
            }
            // Tablet Portrait constraints (744-1024px width, 1133-1440px height)
            else if (screenWidth >= 744 && screenWidth <= 1024) {
              constrainedWidth = screenWidth.clamp(744.0, 1024.0);
              constrainedHeight = screenHeight.clamp(1133.0, 1440.0);
            }

            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(size: Size(constrainedWidth, constrainedHeight)),
              child: widget ?? const SizedBox.shrink(),
            );
          },
          home: const LoginScreen(),
        );
      },
    );
  }
}
