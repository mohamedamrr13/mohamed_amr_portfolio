// lib/main.dart - Enhanced with theme and SEO
import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/seo/seo_wrapper.dart';
import 'package:provider/provider.dart';
import 'package:seo/seo.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_themes.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(MyPortfolio(themeProvider: themeProvider));
}

class MyPortfolio extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MyPortfolio({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return SeoController(
      enabled: true,
      tree: WidgetTree(context: context),
      child: ChangeNotifierProvider(
        create: (_) => themeProvider,
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return SEOWrapper(
              title: 'Mohamed Amr - Flutter Developer Portfolio',
              description:
                  'Professional Flutter Developer specializing in Dart, Flutter, and Firebase. Experienced in building scalable, high-performance mobile and web applications.',
              keywords:
                  'Flutter Developer, Dart, Firebase, Mobile Development, Web Development, Cross-platform, Mohamed Amr, Portfolio, Alexandria Egypt',
              image: 'https://mamr.vercel.app/assets/images/myImage.jpg',
              url: 'https://mamr.vercel.app',

              child: MaterialApp(
                title: 'Mohamed Amr - Flutter Developer',
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                themeMode: themeProvider.themeMode,
                home: const HomeScreen(),
                debugShowCheckedModeBanner: false,
                themeAnimationDuration: const Duration(milliseconds: 600),
                themeAnimationCurve: Curves.easeInOut,
              ),
            );
          },
        ),
      ),
    );
  }
}
