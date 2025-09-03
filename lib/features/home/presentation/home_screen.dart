import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/shared/background_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/shared/custom_button.dart';
import '../../../core/shared/custom_text.dart';
import '../../../core/shared/theme_toggle_button.dart';
import '../../../core/theming/app_colors.dart';
import '../../../core/theming/theme_provider.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/utils/scroll_controller.dart';
import 'widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.primaryColorDark
                  : AppColors.lightBackground,
          body: const EnhancedBackgroundWidget(child: HomeScreenBody()),
          appBar: _buildAppBar(context, themeProvider),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final isMobile = Responsive.isMobile(context);

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: isMobile ? null : double.maxFinite,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.developer_mode,
              color:
                  themeProvider.isDarkMode
                      ? AppColors.white
                      : AppColors.darkText,
              size: 28,
            ),
          ),
          const SizedBox(width: 7),
          SeoText(
            "Mohamed Amr's Portfolio",
            fontSize: Responsive.isTablet(context) || isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
            color:
                themeProvider.isDarkMode ? AppColors.white : AppColors.darkText,
          ),
        ],
      ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
      actions: [
        // Theme toggle button
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: const ThemeToggleButton().animate().fadeIn(
            duration: 1000.ms,
            delay: 200.ms,
          ),
        ),
        // Navigation menu
        ...(Responsive.getWidth(context) < 850
            ? [_buildMobileMenu(context, themeProvider)]
            : _buildDesktopActions(themeProvider)),
      ],
    );
  }

  Widget _buildMobileMenu(BuildContext context, ThemeProvider themeProvider) {
    return PopupMenuButton<String>(
      icon: Icon(
        Icons.menu,
        color: themeProvider.isDarkMode ? AppColors.white : AppColors.darkText,
      ),
      color:
          themeProvider.isDarkMode
              ? AppColors.buttonColorDark
              : AppColors.buttonColorLight,
      onSelected: (value) => PortfolioScrollController.scrollToSection(value),
      itemBuilder:
          (context) => [
            _buildPopupMenuItem('about', 'About', themeProvider),
            _buildPopupMenuItem('experience', 'Experience', themeProvider),
            _buildPopupMenuItem('projects', 'Projects', themeProvider),
            _buildPopupMenuItem('skills', 'Skills', themeProvider),
            _buildPopupMenuItem('contact', 'Contact', themeProvider),
          ],
    ).animate().fadeIn(duration: 1000.ms, delay: 400.ms);
  }

  PopupMenuItem<String> _buildPopupMenuItem(
    String value,
    String text,
    ThemeProvider themeProvider,
  ) {
    return PopupMenuItem<String>(
      value: value,
      child: SeoText(
        text,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: themeProvider.isDarkMode ? AppColors.white : AppColors.darkText,
      ),
    );
  }

  List<Widget> _buildDesktopActions(ThemeProvider themeProvider) {
    final navigationItems = [
      ('about', 'About'),
      ('experience', 'Experience'),
      ('projects', 'Projects'),
      ('skills', 'Skills'),
      ('contact', 'Contact'),
    ];

    return [
      ...navigationItems.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        return CustomButton(
              onPressed:
                  () => PortfolioScrollController.scrollToSection(item.$1),
              shrinkWrap: true,
              backgroundColor:
                  themeProvider.isDarkMode
                      ? AppColors.buttonColorDark
                      : AppColors.buttonColorLight,
              child: SeoText(
                item.$2,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.white
                        : AppColors.darkText,
              ),
            )
            .animate()
            .fadeIn(
              duration: 800.ms,
              delay: Duration(milliseconds: 600 + (index * 100)),
            )
            .slideY(begin: -0.3);
      }),
      const SizedBox(width: 16),
    ];
  }
}
