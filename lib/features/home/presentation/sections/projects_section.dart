import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// Constants for better performance
class ProjectConstants {
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration cardAnimationDuration = Duration(milliseconds: 200);
  static const Duration overlayAnimationDuration = Duration(milliseconds: 250);
  static const Duration imageEffectDuration = Duration(milliseconds: 400);
  static const Curve hoverCurve = Curves.easeOutCubic;
  static const double hoverScale = 1.05;
  static const double hoverElevation = 20.0;
  static const double normalElevation = 5.0;
}

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int? _expandedCardIndex; // Track which card is expanded on mobile

  // Static project data to avoid recreation on each build
  static const List<Map<String, dynamic>> _projects = [
    {
      'title': 'Muslim 🕌',
      'description':
          'A modern prayer and spiritual assistant app that displays prayer times using location-based API, integrated Qiblah compass, daily Azkar screen, and native Android home screen widget for prayer times.',
      'image': 'assets/images/muslim_mockup.jpg',
      'technologies': [
        'Flutter',
        'Kotlin',
        'Location API',
        'Native Android',
        'Widget Development',
      ],
      'type': 'Mobile App',
      'status': 'Completed',
      'hasRepo': true,
      'hasApk': true,
      'repoUrl': 'https://github.com/Fady4Mohamed/muslim',
      'apkUrl':
          'https://drive.google.com/file/d/1YH6agh5G4NxOqxa4PGoUORLG5eEggfIP/view?usp=drive_link',
    },
    {
      'title': 'MugLife',
      'description':
          'An E-Commerce mobile app where you can order food, drinks and dessert built with Clean architecture and clean Firebase authentication. Includes order management, credit card integration, and user profile systems.',
      'image': 'assets/images/muglife_mockup.png',
      'technologies': [
        'Flutter',
        'Firebase Firestore',
        'Firebase Auth',
        'API Integration',
        'Validation',
        'State Management',
        'Payment Service',
        'User Settings',
      ],
      'type': 'Mobile App',
      'status': 'In Progress',
      'hasRepo': true,
      'hasApk': false,
      'repoUrl': 'https://github.com/mohamedamrr13/MugLife',
      'apkUrl': '',
    },
    {
      'title': 'Sphinx Go 🧳',
      'description':
          'A comprehensive travel booking application for flights, tours, and hotels with integrated user authentication, RESTful API integration using Chopper, and an AI-powered chatbot using Dialogflow for interactive support.',
      'image': 'assets/images/sphinx_go_mockup.png',
      'technologies': [
        'Flutter',
        'BLoC',
        'Chopper',
        'Dialogflow',
        'Google Sign-In',
        'Facebook Sign-In',
        'RESTful API',
        'Chat Bot',
        'Google Maps Integration',
        'Vendor Dashboard',
      ],
      'type': 'Mobile App',
      'status': 'Completed',
      'hasRepo': false,
      'hasApk': false,
      'repoUrl': '',
      'apkUrl': '',
    },
    {
      'title': 'Modern Weather App',
      'description':
          '✅ Smooth UI with dynamic themes\n✅ Detailed weather insights: wind, humidity, pressure & visibility\n✅ City search with recent history\n✅ International support\n✅ Optimized for performance with clean UI',
      'image': 'assets/images/weather_mockup.png',
      'technologies': [
        'Flutter',
        'Clean Architecture',
        'OpenWeatherAPI',
        'BloC Pattern',
        'Search',
      ],
      'type': 'Mobile App',
      'status': 'Completed',
      'hasRepo': true,
      'hasApk': true,
      'repoUrl': 'https://github.com/mohamedamrr13/weather',
      'apkUrl':
          'https://drive.google.com/file/d/10kBV4FFv1WWqWQ1nw0tUqwTg5DLwig6w/view?usp=drive_link',
    },
    {
      'title': 'Balanced Meal 🥗',
      'description':
          'A functional meal ordering app with calorie calculator based on user metrics, Firebase Firestore integration for meal ingredients, custom cart logic with dynamic pricing, and order validation system.',
      'image': 'assets/images/balanced_meal_mockup.png',
      'technologies': [
        'FlutterFlow',
        'Firebase',
        'Firestore',
        'Dart Formulas',
        'Custom Functions',
      ],
      'type': 'Mobile App',
      'status': 'Completed',
      'hasRepo': false,
      'hasApk': false,
      'repoUrl': 'https://app.flutterflow.io/project/balanced-meal-k26szy',
      'apkUrl': '',
    },
    {
      'title': 'Bookly 📚',
      'description':
          'An online book browsing app built with Clean Architecture, integrated with Google Books API to fetch and display book data, and uses Hive for efficient local storage and state persistence.',
      'image': 'assets/images/bookly_app_mockup.png',
      'technologies': [
        'Flutter',
        'Clean Architecture',
        'Google Books API',
        'Hive',
        'Data Caching',
      ],
      'type': 'Mobile App',
      'status': 'Completed',
      'hasRepo': true,
      'hasApk': false,
      'repoUrl': 'https://github.com/mohamedamrr13/clean_arch_bookly',
      'apkUrl': '',
    },
  ];

  // Helper method to get responsive font sizes
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.8; // 80% on mobile
    } else if (Responsive.isTablet(context)) {
      return baseSize * 0.9; // 90% on tablet
    }
    return baseSize; // Full size on desktop
  }

  void _handleCardExpansion(int cardIndex) {
    if (Responsive.isMobile(context)) {
      setState(() {
        _expandedCardIndex = _expandedCardIndex == cardIndex ? null : cardIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'projects',
      globalKey: PortfolioScrollController.sectionKeys['projects'],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final textColor =
              themeProvider.isDarkMode ? AppColors.white : AppColors.black;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle(context, textColor),
              const SizedBox(height: 40),
              _buildProjectsGrid(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, Color textColor) {
    return CustomText(
      "Projects",
      fontSize: _getResponsiveFontSize(context, 28),
      fontWeight: FontWeight.bold,
      color: textColor,
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final crossAxisCount = Responsive.getCrossAxisCount(context);

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: Responsive.isMobile(context) ? 15 : 20,
          mainAxisSpacing: Responsive.isMobile(context) ? 15 : 20,
          childAspectRatio:
              Responsive.isMobile(context)
                  ? 0.9
                  : Responsive.isTablet(context)
                  ? 0.85
                  : 0.8,
        ),
        itemCount: _projects.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 600),
            columnCount: crossAxisCount,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: ProjectCard(
                  project: _projects[index],
                  index: index,
                  isExpanded: _expandedCardIndex == index,
                  onExpansionChanged: () => _handleCardExpansion(index),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Separate StatefulWidget for individual project cards to optimize performance
class ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;

  const ProjectCard({
    super.key,
    required this.project,
    required this.index,
    required this.isExpanded,
    required this.onExpansionChanged,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late AnimationController _overlayController;
  late AnimationController _imageEffectController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _borderAnimation;
  late Animation<double> _overlayOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;
  late Animation<double> _imageGrayscaleAnimation;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: ProjectConstants.hoverDuration,
      vsync: this,
    );

    _overlayController = AnimationController(
      duration: ProjectConstants.overlayAnimationDuration,
      vsync: this,
    );

    _imageEffectController = AnimationController(
      duration: ProjectConstants.imageEffectDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: ProjectConstants.hoverScale,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ProjectConstants.hoverCurve,
      ),
    );

    _elevationAnimation = Tween<double>(
      begin: ProjectConstants.normalElevation,
      end: ProjectConstants.hoverElevation,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ProjectConstants.hoverCurve,
      ),
    );

    _borderAnimation = Tween<double>(begin: 0.2, end: 0.6).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: ProjectConstants.hoverCurve,
      ),
    );

    _overlayOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.easeInOut),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _overlayController, curve: Curves.elasticOut),
    );

    // Image effect animations
    _imageGrayscaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _imageEffectController, curve: Curves.easeInOut),
    );

    _imageScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _imageEffectController,
        curve: Curves.easeOutQuart,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayController.dispose();
    _imageEffectController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    if (_isHovered != hovering) {
      setState(() {
        _isHovered = hovering;
      });

      if (hovering) {
        _animationController.forward();
        _overlayController.forward();
        _imageEffectController.forward();
      } else {
        _animationController.reverse();
        _overlayController.reverse();
        _imageEffectController.reverse();
      }
    }
  }

  void _onMobileTap() {
    if (Responsive.isMobile(context)) {
      widget.onExpansionChanged();

      if (widget.isExpanded) {
        _animationController.forward();
        _overlayController.forward();
        _imageEffectController.forward();
      } else {
        _animationController.reverse();
        _overlayController.reverse();
        _imageEffectController.reverse();
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.85; // 85% on mobile
    } else if (Responsive.isTablet(context)) {
      return baseSize * 0.9; // 90% on tablet
    }
    return baseSize; // Full size on desktop
  }

  double _getResponsivePadding(BuildContext context, double basePadding) {
    if (Responsive.isMobile(context)) {
      return basePadding * 0.7; // 70% on mobile
    } else if (Responsive.isTablet(context)) {
      return basePadding * 0.85; // 85% on tablet
    }
    return basePadding; // Full padding on desktop
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final hasRepo = widget.project['hasRepo'] ?? false;
        final hasApk = widget.project['hasApk'] ?? false;
        final showButtons = hasRepo || hasApk;
        final isMobile = Responsive.isMobile(context);
        final shouldShowOverlay = isMobile ? widget.isExpanded : _isHovered;
        final textColor =
            themeProvider.isDarkMode ? AppColors.white : AppColors.black;
        final subTextColor =
            themeProvider.isDarkMode
                ? AppColors.white.withOpacity(0.8)
                : AppColors.black.withOpacity(0.8);
        final overlayColor =
            themeProvider.isDarkMode
                ? Colors.black.withOpacity(0.7)
                : Colors.white.withOpacity(0.7);

        return GestureDetector(
          onTap: isMobile ? _onMobileTap : null,
          child: MouseRegion(
            onEnter: isMobile ? null : (_) => _onHover(true),
            onExit: isMobile ? null : (_) => _onHover(false),
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _animationController,
                _overlayController,
                _imageEffectController,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: (themeProvider.isDarkMode
                              ? AppColors.buttonColorDark
                              : AppColors.cardLight)
                          .withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: (themeProvider.isDarkMode
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight)
                            .withOpacity(_borderAnimation.value),
                        width:
                            (isMobile && widget.isExpanded) || _isHovered
                                ? 2
                                : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColorLight)
                              .withOpacity(0.1),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value * 0.3),
                          spreadRadius:
                              (isMobile && widget.isExpanded) || _isHovered
                                  ? 2
                                  : 0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _ProjectImage(
                              imagePath: widget.project['image'],
                              textColor: subTextColor,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  _getResponsivePadding(context, 20.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _ProjectHeader(
                                      project: widget.project,
                                      textColor: textColor,
                                      context: context,
                                    ),
                                    SizedBox(
                                      height: _getResponsivePadding(
                                        context,
                                        12,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        widget.project['description'],
                                        fontSize: _getResponsiveFontSize(
                                          context,
                                          13,
                                        ),
                                        fontWeight: FontWeight.w400,
                                        maxLines: isMobile ? 4 : 5,
                                        color: subTextColor,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (isMobile)
                                      SizedBox(
                                        height: _getResponsivePadding(
                                          context,
                                          12,
                                        ),
                                      ),
                                    _TechnologiesWidget(
                                      technologies: List<String>.from(
                                        widget.project['technologies'],
                                      ),
                                      textColor: textColor.withOpacity(0.9),
                                      themeProvider: themeProvider,
                                      context: context,
                                    ),
                                    // Add tap indicator for mobile
                                    if (isMobile && showButtons)
                                      Padding(
                                        padding: EdgeInsets.only(
                                          top: _getResponsivePadding(
                                            context,
                                            8.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            widget.isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.7),
                                            size: _getResponsiveFontSize(
                                              context,
                                              20,
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Debug info for mobile

                        // Hover/Tap overlay with buttons - Simplified approach
                        if (showButtons)
                          Positioned.fill(
                            child: AnimatedContainer(
                              duration:
                                  ProjectConstants.overlayAnimationDuration,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color:
                                    shouldShowOverlay
                                        ? overlayColor
                                        : Colors.transparent,
                              ),
                              child:
                                  shouldShowOverlay
                                      ? Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (hasRepo) ...[
                                              _ActionButton(
                                                onTap: () {
                                                  _launchUrl(
                                                    widget.project['repoUrl'],
                                                  );
                                                },
                                                iconPath:
                                                    'assets/images/github.svg',
                                                label: 'Source Code',
                                                delay: 0,
                                                themeProvider: themeProvider,
                                                context: context,
                                              ),
                                            ],
                                            if (hasRepo && hasApk)
                                              SizedBox(
                                                height: _getResponsivePadding(
                                                  context,
                                                  15,
                                                ),
                                              ),
                                            if (hasApk) ...[
                                              _ActionButton(
                                                onTap: () {
                                                  _launchUrl(
                                                    widget.project['apkUrl'],
                                                  );
                                                },
                                                iconPath:
                                                    'assets/images/apkIcon.svg',
                                                label: 'Download APK',
                                                delay: hasRepo ? 100 : 0,
                                                themeProvider: themeProvider,
                                                context: context,
                                              ),
                                            ],
                                          ],
                                        ),
                                      )
                                      : null,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

// Action button widget for GitHub and APK
class _ActionButton extends StatefulWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String label;
  final int delay;
  final ThemeProvider themeProvider;
  final BuildContext context;

  const _ActionButton({
    required this.onTap,
    required this.iconPath,
    required this.label,
    required this.themeProvider,
    required this.context,
    this.delay = 0,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isPressed = false;

  double _getResponsiveFontSize(double baseSize) {
    if (Responsive.isMobile(widget.context)) {
      return baseSize * 0.85;
    } else if (Responsive.isTablet(widget.context)) {
      return baseSize * 0.9;
    }
    return baseSize;
  }

  double _getResponsivePadding(double basePadding) {
    if (Responsive.isMobile(widget.context)) {
      return basePadding * 0.8;
    } else if (Responsive.isTablet(widget.context)) {
      return basePadding * 0.9;
    }
    return basePadding;
  }

  @override
  Widget build(BuildContext context) {
    final buttonTextColor = AppColors.black;
    final iconColor = ColorFilter.mode(buttonTextColor, BlendMode.srcIn);

    return InkWell(
          onTapDown: (_) => setState(() => _isPressed = true),
          onTapUp: (_) => setState(() => _isPressed = false),
          onTapCancel: () => setState(() => _isPressed = false),
          onTap: widget.onTap,
          child: AnimatedScale(
            scale: _isPressed ? 0.95 : 1.0,
            duration: const Duration(milliseconds: 100),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: _getResponsivePadding(16),
                vertical: _getResponsivePadding(12),
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    widget.iconPath,
                    width: _getResponsiveFontSize(20),
                    height: _getResponsiveFontSize(20),
                    colorFilter: iconColor,
                  ),
                  SizedBox(width: _getResponsivePadding(8)),
                  CustomText(
                    widget.label,
                    fontSize: _getResponsiveFontSize(12),
                    fontWeight: FontWeight.w600,
                    color: buttonTextColor,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.delay))
        .slideY(begin: 0.5, duration: 300.ms, curve: Curves.elasticOut)
        .fadeIn();
  }
}

// Separate widget for project header to optimize rebuilds
class _ProjectHeader extends StatelessWidget {
  final Map<String, dynamic> project;
  final Color textColor;
  final BuildContext context;

  const _ProjectHeader({
    required this.project,
    required this.textColor,
    required this.context,
  });

  double _getResponsiveFontSize(double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.85;
    } else if (Responsive.isTablet(context)) {
      return baseSize * 0.9;
    }
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            project['title'],
            fontSize: _getResponsiveFontSize(18),
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}

// Simple project image without color effects
class _ProjectImage extends StatelessWidget {
  final String imagePath;
  final Color textColor;

  const _ProjectImage({required this.imagePath, required this.textColor});

  @override
  Widget build(BuildContext context) {
    final imageHeight =
        Responsive.isMobile(context)
            ? 180
            : Responsive.isTablet(context)
            ? Responsive.getWidth(context) * 0.15
            : Responsive.getWidth(context) * 0.19;

    return Container(
      height: imageHeight.toDouble(),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        gradient: LinearGradient(
          colors: [AppColors.buttonColorDark, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          cacheHeight: 760,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.buttonColorDark, AppColors.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code, size: 36, color: textColor),
                    const SizedBox(height: 8),
                    CustomText('Project Image', fontSize: 12, color: textColor),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TechnologiesWidget extends StatelessWidget {
  final List<String> technologies;
  final Color textColor;
  final ThemeProvider themeProvider;
  final BuildContext context;

  const _TechnologiesWidget({
    required this.technologies,
    required this.textColor,
    required this.themeProvider,
    required this.context,
  });

  double _getResponsiveFontSize(double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.9;
    } else if (Responsive.isTablet(context)) {
      return baseSize * 0.95;
    }
    return baseSize;
  }

  double _getResponsivePadding(double basePadding) {
    if (Responsive.isMobile(context)) {
      return basePadding * 0.8;
    } else if (Responsive.isTablet(context)) {
      return basePadding * 0.9;
    }
    return basePadding;
  }

  @override
  Widget build(BuildContext context) {
    final maxTechsToShow = Responsive.isMobile(context) ? 4 : 5;

    return Wrap(
      spacing: _getResponsivePadding(6),
      runSpacing: _getResponsivePadding(6),
      children:
          technologies.take(maxTechsToShow).map((tech) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: _getResponsivePadding(8),
                vertical: _getResponsivePadding(4),
              ),
              decoration: BoxDecoration(
                color:
                    themeProvider.isDarkMode
                        ? AppColors.buttonColorDark.withOpacity(0.8)
                        : AppColors.primaryColorLight.withAlpha(60),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: CustomText(
                tech,
                fontSize: _getResponsiveFontSize(10),
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            );
          }).toList(),
    );
  }
}
