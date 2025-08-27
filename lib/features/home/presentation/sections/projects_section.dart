import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/shared/section_wrapper.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';
import 'package:url_launcher/url_launcher.dart';

// Constants for better performance
class ProjectConstants {
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration cardAnimationDuration = Duration(milliseconds: 200);
  static const Duration overlayAnimationDuration = Duration(milliseconds: 250);
  static const Curve hoverCurve = Curves.easeOutCubic;
  static const double hoverScale = 1.05;
  static const double hoverElevation = 20.0;
  static const double normalElevation = 5.0;
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'projects',
      globalKey: PortfolioScrollController.sectionKeys['projects'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSectionTitle(),
          const SizedBox(height: 40),
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const CustomText(
      "Projects",
      fontSize: 28,
      fontWeight: FontWeight.bold,
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
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio:
              Responsive.isMobile(context) || Responsive.isTablet(context)
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
                child: ProjectCard(project: _projects[index]),
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

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  bool _isExpanded = false; // For mobile tap to expand
  late AnimationController _animationController;
  late AnimationController _overlayController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _borderAnimation;
  late Animation<double> _overlayOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;

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
  }

  @override
  void dispose() {
    _animationController.dispose();
    _overlayController.dispose();
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
      } else {
        _animationController.reverse();
        _overlayController.reverse();
      }
    }
  }

  void _onMobileTap() {
    if (Responsive.isMobile(context)) {
      setState(() {
        _isExpanded = !_isExpanded;
      });

      if (_isExpanded) {
        _animationController.forward();
        _overlayController.forward();
      } else {
        _animationController.reverse();
        _overlayController.reverse();
      }
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasRepo = widget.project['hasRepo'] ?? false;
    final hasApk = widget.project['hasApk'] ?? false;
    final showButtons = hasRepo || hasApk;
    final isMobile = Responsive.isMobile(context);
    final shouldShowOverlay = isMobile ? _isExpanded : _isHovered;

    return GestureDetector(
      onTap: isMobile ? _onMobileTap : null,
      child: MouseRegion(
        onEnter: isMobile ? null : (_) => _onHover(true),
        onExit: isMobile ? null : (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _animationController,
            _overlayController,
          ]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.buttonColorDark.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primaryColor.withOpacity(
                      _borderAnimation.value,
                    ),
                    width: (isMobile && _isExpanded) || _isHovered ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value * 0.3),
                      spreadRadius:
                          (isMobile && _isExpanded) || _isHovered ? 2 : 0,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ProjectImage(imagePath: widget.project['image']),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(
                              Responsive.isMobile(context) ? 8.0 : 20.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _ProjectHeader(project: widget.project),
                                SizedBox(
                                  height: Responsive.isMobile(context) ? 8 : 12,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          Responsive.isMobile(context)
                                              ? 10.0
                                              : 0,
                                    ),
                                    child: CustomText(
                                      widget.project['description'],
                                      fontSize:
                                          Responsive.isMobile(context)
                                              ? 10
                                              : 13,
                                      fontWeight: FontWeight.w400,
                                      maxLines: 5,
                                      color: AppColors.white.withOpacity(0.8),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                if (Responsive.isMobile(context))
                                  const SizedBox(height: 20),
                                _TechnologiesWidget(
                                  technologies: List<String>.from(
                                    widget.project['technologies'],
                                  ),
                                ),
                                // Add tap indicator for mobile
                                if (isMobile && showButtons)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Center(
                                      child: Icon(
                                        _isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.7),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Hover/Tap overlay with buttons
                    if (showButtons)
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.black.withOpacity(
                              0.7 * _overlayOpacityAnimation.value,
                            ),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (hasRepo) ...[
                                  Transform.scale(
                                    scale: _buttonScaleAnimation.value,
                                    child: _ActionButton(
                                      onTap: () {
                                        _launchUrl(widget.project['repoUrl']);
                                      },
                                      iconPath: 'assets/images/github.svg',
                                      label: 'Source Code',
                                      delay: 0,
                                    ),
                                  ),
                                ],
                                if (hasRepo && hasApk)
                                  const SizedBox(width: 20),
                                if (hasApk) ...[
                                  Transform.scale(
                                    scale: _buttonScaleAnimation.value,
                                    child: _ActionButton(
                                      onTap: () {
                                        _launchUrl(widget.project['apkUrl']);
                                      },
                                      iconPath: 'assets/images/apkIcon.svg',
                                      label: 'Download APK',
                                      delay: hasRepo ? 100 : 0,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ).animate(target: shouldShowOverlay ? 1 : 0).fadeIn(),
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

// Action button widget for GitHub and APK
class _ActionButton extends StatefulWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String label;
  final int delay;

  const _ActionButton({
    required this.onTap,
    required this.iconPath,
    required this.label,
    this.delay = 0,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
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
                horizontal: Responsive.isMobile(context) ? 12 : 16,
                vertical: Responsive.isMobile(context) ? 8 : 12,
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
                    width: Responsive.isMobile(context) ? 16 : 20,
                    height: Responsive.isMobile(context) ? 16 : 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.black,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: Responsive.isMobile(context) ? 6 : 8),
                  CustomText(
                    widget.label,
                    fontSize: Responsive.isMobile(context) ? 10 : 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
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

  const _ProjectHeader({required this.project});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            project['title'],
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        _TypeBadge(type: project['type']),
      ],
    );
  }
}

// Separate widget for type badge
class _TypeBadge extends StatelessWidget {
  final String type;

  const _TypeBadge({required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        type,
        fontSize: 10,
        fontWeight: FontWeight.w500,
        color: AppColors.primaryColor,
      ),
    );
  }
}

// Separate widget for project image
class _ProjectImage extends StatelessWidget {
  final String imagePath;

  const _ProjectImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          Responsive.isMobile(context)
              ? 200
              : Responsive.getWidth(context) * 0.19,
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
                    Icon(
                      Icons.code,
                      size: 36,
                      color: AppColors.white.withOpacity(0.8),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      'Project Image',
                      fontSize: 12,
                      color: AppColors.white.withOpacity(0.6),
                    ),
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

  const _TechnologiesWidget({required this.technologies});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children:
          technologies.take(5).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.buttonColorDark.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: CustomText(
                tech,
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.9),
              ),
            );
          }).toList(),
    );
  }
}
