// lib/features/home/presentation/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mohamed_amr_portfolio/core/shared/background_widget.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_button.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/theme_toggle_button.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _appBarAnimationController;
  late Animation<double> _appBarElevation;
  late Animation<double> _appBarBlur;
  late Animation<Color?> _appBarColor;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    // Initialize animation controller for smooth transitions
    _appBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _appBarElevation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(
        parent: _appBarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    _appBarBlur = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(
        parent: _appBarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    // Add scroll listener
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldBeScrolled = _scrollController.offset > 50;
    if (shouldBeScrolled != _isScrolled) {
      setState(() {
        _isScrolled = shouldBeScrolled;
        if (_isScrolled) {
          _appBarAnimationController.forward();
        } else {
          _appBarAnimationController.reverse();
        }
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appBarAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        // Update color animation based on theme
        _appBarColor = ColorTween(
          begin: Colors.transparent,
          end:
              themeProvider.isDarkMode
                  ? AppColors.primaryColorDark.withOpacity(0.95)
                  : Colors.white.withOpacity(0.98),
        ).animate(
          CurvedAnimation(
            parent: _appBarAnimationController,
            curve: Curves.easeInOut,
          ),
        );

        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.primaryColorDark
                  : const Color(0xFFFDFDFE), // Softer light background
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              BackgroundWidget(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: const HomeScreenBody(),
                ),
              ),
              _buildAnimatedAppBar(context, themeProvider),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAnimatedAppBar(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedBuilder(
      animation: _appBarAnimationController,
      builder: (context, child) {
        return Container(
          height: kToolbarHeight + MediaQuery.of(context).padding.top,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ColorFilter.mode(
                Colors.transparent,
                _appBarBlur.value > 0 ? BlendMode.src : BlendMode.dst,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: _appBarColor.value,
                  border:
                      _isScrolled
                          ? Border(
                            bottom: BorderSide(
                              color:
                                  themeProvider.isDarkMode
                                      ? Colors.white.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.2),
                              width: 0.5,
                            ),
                          )
                          : null,
                  boxShadow:
                      _isScrolled
                          ? [
                            BoxShadow(
                              color:
                                  themeProvider.isDarkMode
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.black.withOpacity(0.08),
                              blurRadius: _appBarElevation.value,
                              offset: const Offset(0, 2),
                            ),
                          ]
                          : null,
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        // Logo and title with subtle animation
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                            0,
                            _isScrolled ? 0 : 0,
                            0,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedRotation(
                                duration: const Duration(milliseconds: 600),
                                turns: _isScrolled ? 0.05 : 0,
                                child: Icon(
                                  Icons.developer_mode,
                                  color:
                                      themeProvider.isDarkMode
                                          ? AppColors.white
                                          : const Color(0xFF2D3748),
                                  size: _isScrolled ? 26 : 28,
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedDefaultTextStyle(
                                duration: const Duration(milliseconds: 300),
                                style: TextStyle(
                                  fontSize:
                                      Responsive.isTablet(context) || isMobile
                                          ? (_isScrolled ? 16 : 18)
                                          : (_isScrolled ? 20 : 22),
                                  fontWeight: FontWeight.bold,
                                  color:
                                      themeProvider.isDarkMode
                                          ? AppColors.white
                                          : const Color(0xFF1A202C),
                                ),
                                child: const Text("Mohamed Amr's Portfolio"),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        // Actions with fade animation
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 300),
                          opacity: _isScrolled ? 1.0 : 0.95,
                          child: Row(
                            children: [
                              // Enhanced theme toggle
                              EnhancedThemeToggleButton(
                                isScrolled: _isScrolled,
                              ),
                              const SizedBox(width: 12),
                              // Navigation items
                              ...(Responsive.getWidth(context) < 850
                                  ? [_buildMobileMenu(context, themeProvider)]
                                  : _buildDesktopActions(themeProvider)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMobileMenu(BuildContext context, ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        color:
            _isScrolled
                ? (themeProvider.isDarkMode
                    ? Colors.white.withOpacity(0.1)
                    : Colors.grey.withOpacity(0.1))
                : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          color:
              themeProvider.isDarkMode
                  ? AppColors.white
                  : const Color(0xFF2D3748),
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => _buildMobileMenuSheet(context, themeProvider),
          );
        },
      ),
    );
  }

  Widget _buildMobileMenuSheet(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Container(
      decoration: BoxDecoration(
        color:
            themeProvider.isDarkMode ? AppColors.buttonColorDark : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          ..._buildMobileMenuItems(themeProvider),
        ],
      ),
    );
  }

  List<Widget> _buildMobileMenuItems(ThemeProvider themeProvider) {
    final items = [
      {'value': 'about', 'text': 'About', 'icon': Icons.person_outline},
      {'value': 'experience', 'text': 'Experience', 'icon': Icons.work_outline},
      {
        'value': 'projects',
        'text': 'Projects',
        'icon': Icons.folder_copy_outlined,
      },
      {'value': 'skills', 'text': 'Skills', 'icon': Icons.code},
      {'value': 'contact', 'text': 'Contact', 'icon': Icons.mail_outline},
    ];

    return items.map((item) {
      return ListTile(
        leading: Icon(
          item['icon'] as IconData,
          color:
              themeProvider.isDarkMode
                  ? AppColors.white
                  : const Color(0xFF2D3748),
        ),
        title: Text(
          item['text'] as String,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color:
                themeProvider.isDarkMode
                    ? AppColors.white
                    : const Color(0xFF2D3748),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
          PortfolioScrollController.scrollToSection(item['value'] as String);
        },
      );
    }).toList();
  }

  List<Widget> _buildDesktopActions(ThemeProvider themeProvider) {
    final navItems = [
      {'text': 'About', 'section': 'about'},
      {'text': 'Experience', 'section': 'experience'},
      {'text': 'Projects', 'section': 'projects'},
      {'text': 'Skills', 'section': 'skills'},
      {'text': 'Contact', 'section': 'contact'},
    ];

    return navItems.map((item) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextButton(
          onPressed:
              () => PortfolioScrollController.scrollToSection(item['section']!),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            item['text']!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color:
                  themeProvider.isDarkMode
                      ? AppColors.white
                      : (_isScrolled
                          ? const Color(0xFF2D3748)
                          : const Color(0xFF4A5568)),
            ),
          ),
        ),
      );
    }).toList();
  }
}

// Enhanced Theme Toggle Button Widget
class EnhancedThemeToggleButton extends StatefulWidget {
  final bool isScrolled;

  const EnhancedThemeToggleButton({super.key, this.isScrolled = false});

  @override
  State<EnhancedThemeToggleButton> createState() =>
      _EnhancedThemeToggleButtonState();
}

class _EnhancedThemeToggleButtonState extends State<EnhancedThemeToggleButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _rotation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color:
                widget.isScrolled
                    ? (themeProvider.isDarkMode
                        ? Colors.white.withOpacity(0.1)
                        : const Color(0xFFF7FAFC))
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  themeProvider.isDarkMode
                      ? Colors.white.withOpacity(0.2)
                      : Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                _controller.forward(from: 0);
                themeProvider.toggleTheme();
              },
              child: AnimatedBuilder(
                animation: _rotation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotation.value * 2 * 3.14159,
                    child: Icon(
                      themeProvider.isDarkMode
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      size: 20,
                      color:
                          themeProvider.isDarkMode
                              ? const Color(0xFFFFD700)
                              : const Color(0xFF4A5568),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
