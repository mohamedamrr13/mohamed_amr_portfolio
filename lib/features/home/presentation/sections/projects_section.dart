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
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/project_image_page_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int? _expandedCardIndex;

  static final List<Map<String, dynamic>> _projects = [
    {
      'title': 'Muslim',
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
      'hasGallery': false, // Add images later
      'repoUrl': 'https://github.com/Fady4Mohamed/muslim',
      'apkUrl':
          'https://drive.google.com/file/d/1YH6agh5G4NxOqxa4PGoUORLG5eEggfIP/view?usp=drive_link',
      'galleryImages': [], // Placeholder for future images
    },
    {
      'title': 'MugLife',
      'description':
          'An E-Commerce mobile app where you can order food and drinks, built with Clean architecture and clean Firebase authentication. Includes order management and credit card integration.',
      'image': 'assets/images/muglife_mockup.png',
      'technologies': [
        'Flutter',
        'Firebase Firestore',
        'Firebase Auth',
        'State Management',
        'Payment Service',
        'User Settings',
      ],
      'type': 'Mobile App',
      'status': 'In Progress',
      'hasRepo': true,
      'hasApk': false,
      'hasGallery': true,
      'repoUrl': 'https://github.com/mohamedamrr13/MugLife',
      'apkUrl': '',
      'galleryImages': [
        'assets/images/muglife splash.png',
        ...List.generate(
          11,
          (index) => 'assets/images/muglife ${index + 1}.png',
        ),
      ],
    },
    {
      'title': 'Sphinx Go',
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
      'hasApk': true,
      'hasGallery': true, // Add images later
      'repoUrl': '',
      'apkUrl':
          'https://drive.google.com/file/d/15-lBDJKZOBKvYRifmnqxvPz86KCmmTb5/view?usp=drive_link',
      'galleryImages': [
        ...List.generate(
          24,
          (index) => 'assets/images/sphinx ${index + 1}.png',
        ),
      ], // Placeholder for future images
    },
    {
      'title': 'Modern Weather App',
      'description':
          'Smooth UI with dynamic themes, detailed weather insights including wind, humidity, pressure & visibility, city search with recent history, international support, and optimized performance with clean UI.',
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
      'hasGallery': false, // Add images later
      'repoUrl': 'https://github.com/mohamedamrr13/weather',
      'apkUrl':
          'https://drive.google.com/file/d/10kBV4FFv1WWqWQ1nw0tUqwTg5DLwig6w/view?usp=drive_link',
      'galleryImages': [], // Placeholder for future images
    },
    {
      'title': 'Minesweeper',
      'description':
          'A classic Minesweeper implementation built with Flutter, Highscore ranking using local database, featuring modern UI design and comprehensive gameplay mechanics.',
      'image': 'assets/images/minesweeper_mockup.png',
      'technologies': ['Flutter', 'Hive', 'Lottie', 'Dart Formulas', '2D'],
      'type': 'Mobile Game',
      'status': 'Completed',
      'hasRepo': true,
      'hasApk': true,
      'hasGallery': false, // Add images laters
      'repoUrl': 'https://github.com/mohamedamrr13/Minesweeper',
      'apkUrl':
          'https://drive.google.com/file/d/17oZSD9cV-mbNt9nYxYFW2m98-ILLNjFp/view?usp=drive_link',
      'galleryImages': [], // Placeholder for future images
    },
    {
      'title': 'Balanced Meal',
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
      'hasRepo': true,
      'hasApk': false,
      'hasGallery': false, // Add images later
      'repoUrl': 'https://app.flutterflow.io/project/balanced-meal-k26szy',
      'apkUrl': '',
      'galleryImages': [], // Placeholder for future images
    },
    {
      'title': 'Bookly',
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
      'hasGallery': false, // Add images later
      'repoUrl': 'https://github.com/mohamedamrr13/bookly',
      'apkUrl': '',
      'galleryImages': [], // Placeholder for future images
    },
  ];

  void _handleCardExpansion(int cardIndex) {
    if (Responsive.isMobile(context)) {
      setState(() {
        _expandedCardIndex = _expandedCardIndex == cardIndex ? null : cardIndex;
      });
    }
  }

  void _navigateToGallery(Map<String, dynamic> project) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder:
            (context, animation, secondaryAnimation) => ProjectGalleryPage(
              projectTitle: project['title'],
              imagePaths: List<String>.from(project['galleryImages']),
            ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'projects',
      globalKey: PortfolioScrollController.sectionKeys['projects'],
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Responsive.getMaxContentWidth(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Responsive.getVerticalPadding(context)),
          _buildSectionTitle(context),
          SizedBox(height: Responsive.getSpacing(context, multiplier: 2.5)),
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CustomText(
          "Featured Projects",
          fontSize: Responsive.getFontSize(context, mobile: 28, desktop: 36),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    // Get screen width and calculate optimal layout
    final screenWidth = MediaQuery.of(context).size.width;
    Responsive.getSpacing(context);
    Responsive.getMaxContentWidth(context);

    // Calculate responsive grid parameters
    int crossAxisCount;
    double childAspectRatio;
    double spacing = Responsive.getSpacing(context);

    if (screenWidth <= 800) {
      // Mobile: 1 column
      crossAxisCount = 1;
      childAspectRatio = 0.7;
    } else if (screenWidth <= 1300) {
      // Tablet: 2 columns
      crossAxisCount = 2;
      childAspectRatio = 0.75;
      spacing = Responsive.getSpacing(context, multiplier: 0.75);
    } else {
      // Small desktop: 2 columns with better ratio
      crossAxisCount = 3;
      childAspectRatio = 0.8;
    }

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: spacing,
          mainAxisSpacing: spacing,
          childAspectRatio: childAspectRatio,
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
                child: _ProjectCard(
                  project: _projects[index],
                  index: index,
                  isExpanded: _expandedCardIndex == index,
                  onExpansionChanged: () => _handleCardExpansion(index),
                  onGalleryTap: () => _navigateToGallery(_projects[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;
  final bool isExpanded;
  final VoidCallback onExpansionChanged;
  final VoidCallback onGalleryTap;

  const _ProjectCard({
    required this.project,
    required this.index,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.onGalleryTap,
  });

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late AnimationController _overlayController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _overlayController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(begin: 4.0, end: 16.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _borderAnimation = Tween<double>(begin: 0.2, end: 0.4).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    _overlayController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    if (_isHovered != hovering) {
      setState(() => _isHovered = hovering);
      if (hovering) {
        _hoverController.forward();
        _overlayController.forward();
      } else {
        _hoverController.reverse();
        _overlayController.reverse();
      }
    }
  }

  void _handleMobileTap() {
    if (Responsive.isMobile(context)) {
      widget.onExpansionChanged();
      if (widget.isExpanded) {
        _hoverController.forward();
        _overlayController.forward();
      } else {
        _hoverController.reverse();
        _overlayController.reverse();
      }
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final hasRepo = widget.project['hasRepo'] ?? false;
        final hasApk = widget.project['hasApk'] ?? false;
        final hasGallery = widget.project['hasGallery'] ?? false;
        final showButtons = hasRepo || hasApk || hasGallery;
        final isMobile = MediaQuery.of(context).size.width <= 600;
        final shouldShowOverlay = isMobile ? widget.isExpanded : _isHovered;

        return GestureDetector(
          onTap: isMobile ? _handleMobileTap : null,
          child: MouseRegion(
            onEnter: isMobile ? null : (_) => _handleHover(true),
            onExit: isMobile ? null : (_) => _handleHover(false),
            child: AnimatedBuilder(
              animation: Listenable.merge([
                _hoverController,
                _overlayController,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      color: (themeProvider.isDarkMode
                              ? AppColors.buttonColorDark
                              : AppColors.cardLight)
                          .withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: (themeProvider.isDarkMode
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight)
                            .withOpacity(_borderAnimation.value),
                        width: shouldShowOverlay ? 2 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColorLight)
                              .withOpacity(0.1),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value * 0.3),
                          spreadRadius: shouldShowOverlay ? 2 : 0,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildProjectImage(),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(
                                  Responsive.getSpacing(
                                    context,
                                    multiplier: 1.25,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildProjectHeader(context, themeProvider),
                                    SizedBox(
                                      height: Responsive.getSpacing(
                                        context,
                                        multiplier: 0.75,
                                      ),
                                    ),

                                    Expanded(
                                      child: _buildProjectDescription(
                                        context,
                                        themeProvider,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Responsive.getSpacing(
                                        context,
                                        multiplier: 0.75,
                                      ),
                                    ),
                                    _buildTechnologies(context, themeProvider),
                                    if (isMobile && showButtons) ...[
                                      SizedBox(
                                        height: Responsive.getSpacing(
                                          context,
                                          multiplier: 0.5,
                                        ),
                                      ),
                                      _buildMobileTapIndicator(themeProvider),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (showButtons)
                          _buildActionOverlay(
                            context,
                            themeProvider,
                            shouldShowOverlay,
                            hasRepo,
                            hasApk,
                            hasGallery,
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

  Widget _buildProjectImage() {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive image height
    double imageHeight;
    if (screenWidth <= 900) {
      imageHeight = 220;
    } else if (screenWidth <= 1300) {
      imageHeight = 250;
    } else {
      imageHeight = 280;
    }

    return Container(
      height: imageHeight,
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        gradient: LinearGradient(
          colors: [AppColors.buttonColorDark, AppColors.primaryColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Image.asset(
          widget.project['image'],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.buttonColorDark, AppColors.primaryColor],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.code, size: 36, color: Colors.white),
                    SizedBox(height: 8),
                    CustomText(
                      'Project Image',
                      fontSize: 12,
                      color: Colors.white,
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

  Widget _buildProjectHeader(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            widget.project['title'],
            fontSize: Responsive.getFontSize(context, mobile: 16, desktop: 18),
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
          ),
        ),
        _buildStatusChip(context, themeProvider),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, ThemeProvider themeProvider) {
    final status = widget.project['status'] as String;
    final isCompleted = status == 'Completed';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSpacing(context, multiplier: 0.5),
        vertical: Responsive.getSpacing(context, multiplier: 0.25),
      ),
      decoration: BoxDecoration(
        color:
            isCompleted
                ? Colors.green.withOpacity(0.15)
                : Colors.orange.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              isCompleted
                  ? Colors.green.withOpacity(0.4)
                  : Colors.orange.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: isCompleted ? Colors.green : Colors.orange,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: Responsive.getSpacing(context, multiplier: 0.25)),
          CustomText(
            status,
            fontSize: Responsive.getFontSize(context, mobile: 9, desktop: 10),
            fontWeight: FontWeight.w600,
            color: isCompleted ? Colors.green : Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildProjectDescription(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxLines = screenWidth <= 600 ? 5 : (screenWidth <= 900 ? 7 : 9);

    return CustomText(
      widget.project['description'],
      fontSize: Responsive.getFontSize(context, mobile: 13, desktop: 14),
      fontWeight: FontWeight.w400,
      maxLines: maxLines,
      color: (themeProvider.isDarkMode ? AppColors.white : AppColors.darkText)
          .withOpacity(0.8),
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildTechnologies(BuildContext context, ThemeProvider themeProvider) {
    final technologies = widget.project['technologies'] as List<String>;
    final screenWidth = MediaQuery.of(context).size.width;
    final maxTechsToShow =
        screenWidth <= 600 ? 3 : (screenWidth <= 900 ? 4 : 5);

    return Wrap(
      spacing: Responsive.getSpacing(context, multiplier: 0.375),
      runSpacing: Responsive.getSpacing(context, multiplier: 0.375),
      children:
          technologies.take(maxTechsToShow).map((tech) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getSpacing(context, multiplier: 0.5),
                vertical: Responsive.getSpacing(context, multiplier: 0.25),
              ),
              decoration: BoxDecoration(
                color:
                    themeProvider.isDarkMode
                        ? AppColors.buttonColorDark.withOpacity(0.8)
                        : AppColors.primaryColorLight.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: (themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight)
                      .withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: CustomText(
                tech,
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 9,
                  desktop: 10,
                ),
                fontWeight: FontWeight.w500,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.white.withOpacity(0.9)
                        : AppColors.darkText.withOpacity(0.9),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildMobileTapIndicator(ThemeProvider themeProvider) {
    return Center(
      child: Icon(
        widget.isExpanded
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded,
        color: (themeProvider.isDarkMode
                ? AppColors.primaryColor
                : AppColors.primaryColorLight)
            .withOpacity(0.7),
        size: Responsive.getIconSize(context, multiplier: 1.2),
      ),
    );
  }

  Widget _buildActionOverlay(
    BuildContext context,
    ThemeProvider themeProvider,
    bool shouldShowOverlay,
    bool hasRepo,
    bool hasApk,
    bool hasGallery,
  ) {
    return Positioned.fill(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:
              shouldShowOverlay
                  ? (themeProvider.isDarkMode
                          ? Colors.black.withOpacity(0.7)
                          : Colors.white.withOpacity(0.85))
                      .withOpacity(0.9)
                  : Colors.transparent,
        ),
        child:
            shouldShowOverlay
                ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (hasRepo) ...[
                        _ActionButton(
                          onTap: () => _launchUrl(widget.project['repoUrl']),
                          iconPath:
                              widget.project['title'].toString().contains(
                                    "Balanced",
                                  )
                                  ? 'assets/images/demo.svg'
                                  : 'assets/images/github.svg',
                          label:
                              widget.project['title'].toString().contains(
                                    "Balanced",
                                  )
                                  ? 'FlutterFlow Project'
                                  : 'Source Code',
                          delay: 0,
                          themeProvider: themeProvider,
                        ),
                      ],
                      if ((hasRepo && hasApk) || (hasRepo && hasGallery))
                        SizedBox(
                          height: Responsive.getSpacing(
                            context,
                            multiplier: 0.75,
                          ),
                        ),
                      if (hasApk) ...[
                        _ActionButton(
                          onTap: () => _launchUrl(widget.project['apkUrl']),
                          iconPath:
                              widget.project['title'].toString().contains(
                                    'Sphinx',
                                  )
                                  ? 'assets/images/demo.svg'
                                  : 'assets/images/apkIcon.svg',
                          label:
                              widget.project['title'].toString().contains(
                                    'Sphinx',
                                  )
                                  ? 'Video Demo'
                                  : 'Download APK',
                          delay: hasRepo ? 100 : 0,
                          themeProvider: themeProvider,
                        ),
                      ],
                      if ((hasApk && hasGallery) ||
                          (hasRepo && hasApk && hasGallery))
                        SizedBox(
                          height: Responsive.getSpacing(
                            context,
                            multiplier: 0.75,
                          ),
                        ),
                      if (hasGallery) ...[
                        _ActionButton(
                          onTap: widget.onGalleryTap,
                          iconPath: 'assets/images/gallery.svg',
                          label: 'View Gallery',
                          delay:
                              (hasRepo && hasApk)
                                  ? 200
                                  : (hasRepo || hasApk)
                                  ? 100
                                  : 0,
                          themeProvider: themeProvider,
                        ),
                      ],
                    ],
                  ),
                )
                : null,
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final VoidCallback onTap;
  final String iconPath;
  final String label;
  final int delay;
  final ThemeProvider themeProvider;

  const _ActionButton({
    required this.onTap,
    required this.iconPath,
    required this.label,
    required this.delay,
    required this.themeProvider,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(begin: 8.0, end: 12.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
    if (hovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isPressed ? 0.95 : _scaleAnimation.value,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getSpacing(context, multiplier: 1),
                      vertical: Responsive.getSpacing(
                        context,
                        multiplier: 0.75,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.themeProvider.isDarkMode
                              ? AppColors.primaryColor
                              : AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: (widget.themeProvider.isDarkMode
                                ? AppColors.primaryColor
                                : AppColors.primaryColor)
                            .withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (widget.themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor)
                              .withOpacity(0.3),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value * 0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildIcon(),
                        SizedBox(
                          width: Responsive.getSpacing(
                            context,
                            multiplier: 0.5,
                          ),
                        ),
                        CustomText(
                          widget.label,
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 12,
                            desktop: 13,
                          ),
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: widget.delay))
        .slideY(begin: 0.5, duration: 300.ms, curve: Curves.elasticOut)
        .fadeIn();
  }

  Widget _buildIcon() {
    // Handle gallery icon differently since it might not be an SVG
    if (widget.iconPath.contains('gallery')) {
      return Icon(
        Icons.photo_library_outlined,
        size: Responsive.getIconSize(context),
        color: AppColors.black,
      );
    }

    return SvgPicture.asset(
      widget.iconPath,
      width: Responsive.getIconSize(context),
      height: Responsive.getIconSize(context),
      colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
    );
  }
}
