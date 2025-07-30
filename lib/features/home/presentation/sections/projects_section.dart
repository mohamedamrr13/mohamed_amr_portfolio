import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/shared/section_wrapper.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';

// Constants for better performance
class ProjectConstants {
  static const Duration hoverDuration = Duration(milliseconds: 300);
  static const Duration cardAnimationDuration = Duration(milliseconds: 200);
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
    },
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
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: ProjectConstants.hoverDuration,
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
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    if (_isHovered != hovering) {
      setState(() {
        _isHovered = hovering;
      });

      if (hovering) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _animationController,
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
                  width: _isHovered ? 2 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    blurRadius: _elevationAnimation.value,
                    offset: Offset(0, _elevationAnimation.value * 0.3),
                    spreadRadius: _isHovered ? 2 : 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProjectImage(imagePath: widget.project['image']),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(
                        Responsive.isMobile(context) ? 8.0 : 20.0,
                      ), // Responsive padding
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _ProjectHeader(project: widget.project),
                          SizedBox(
                            height: Responsive.isMobile(context) ? 8 : 12,
                          ), // Responsive spacing
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical:
                                    Responsive.isMobile(context) ? 10.0 : 0,
                              ),
                              child: CustomText(
                                widget.project['description'],
                                fontSize:
                                    Responsive.isMobile(context)
                                        ? 10
                                        : 13, // Responsive font size
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
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
            fontSize: 18, // Increased from 16
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8), // Increased from 4
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
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ), // Increased padding
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: CustomText(
        type,
        fontSize: 10, // Increased from 8
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
          // Add cache settings for better performance
          cacheHeight: 760, // 2x the display height for high DPI
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
                      size: 36, // Increased icon size
                      color: AppColors.white.withOpacity(0.8),
                    ),
                    const SizedBox(height: 8), // Increased from 4
                    CustomText(
                      'Project Image',
                      fontSize: 12, // Increased from 10
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
      spacing: 6, // Increased from 4
      runSpacing: 6, // Increased from 4
      children:
          technologies.take(5).map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ), // Increased padding
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
                fontSize: 10, // Increased from 8
                fontWeight: FontWeight.w500,
                color: AppColors.white.withOpacity(0.9),
              ),
            );
          }).toList(),
    );
  }
}
