import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/seo/seo_wrapper.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/project_image_page_screen.dart';
import 'package:mohamed_amr_portfolio/portfolio_config.dart';
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
                initialRoute: '/',
                onGenerateRoute: (settings) {
                  // Home route - full config (with contact)
                  if (settings.name == '/' ||
                      (settings.name?.isEmpty ?? false)) {
                    return MaterialPageRoute(
                      builder:
                          (_) => HomeScreen(config: PortfolioConfig.full()),
                    );
                  }
                  // Freelance route - without contact
                  else if (settings.name == '/freelance') {
                    return MaterialPageRoute(
                      builder:
                          (_) =>
                              HomeScreen(config: PortfolioConfig.freelance()),
                    );
                  }
                  // Project gallery route
                  else if (settings.name?.startsWith('/project/') ?? false) {
                    final projectTitle = settings.name!.substring(
                      '/project/'.length,
                    );
                    final args = settings.arguments as Map<String, dynamic>?;

                    return PageRouteBuilder(
                      settings: settings,
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              ProjectGalleryPage(
                                projectTitle:
                                    args?['title'] ??
                                    Uri.decodeComponent(projectTitle),
                                imagePaths: List<String>.from(
                                  args?['galleryImages'] ?? [],
                                ),
                              ),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.easeInOut;

                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));

                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 400),
                    );
                  }

                  // Default fallback
                  return null;
                },
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
