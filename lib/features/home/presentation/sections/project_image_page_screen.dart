import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:provider/provider.dart';

class ProjectGalleryPage extends StatefulWidget {
  final String projectTitle;
  final List<String> imagePaths;

  const ProjectGalleryPage({
    super.key,
    required this.projectTitle,
    required this.imagePaths,
  });

  @override
  State<ProjectGalleryPage> createState() => _ProjectGalleryPageState();
}

class _ProjectGalleryPageState extends State<ProjectGalleryPage>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentImageIndex = 0;
  bool _showFullscreen = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _toggleFullscreen() {
    setState(() {
      _showFullscreen = !_showFullscreen;
    });
  }

  void _navigateToImage(int index) {
    setState(() {
      _currentImageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor:
              themeProvider.isDarkMode
                  ? AppColors.primaryColorDark
                  : AppColors.lightBackground,
          body:
              _showFullscreen
                  ? _buildFullscreenView(themeProvider)
                  : _buildNormalView(themeProvider),
        );
      },
    );
  }

  Widget _buildNormalView(ThemeProvider themeProvider) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: CustomScrollView(
        slivers: [
          _buildAppBar(themeProvider),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Responsive.getHorizontalPadding(context)),
              child: Column(
                children: [
                  _buildMainImageViewer(themeProvider),
                  SizedBox(
                    height: Responsive.getSpacing(context, multiplier: 2),
                  ),
                  _buildImageThumbnails(themeProvider),
                  SizedBox(height: Responsive.getVerticalPadding(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(ThemeProvider themeProvider) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor:
          themeProvider.isDarkMode
              ? AppColors.primaryColorDark
              : AppColors.lightBackground,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: CustomText(
          '${widget.projectTitle} Gallery',
          fontSize: Responsive.getFontSize(context, mobile: 18, desktop: 22),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ),
        centerTitle: true,
        titlePadding: EdgeInsets.only(
          bottom: 16,
          left: Responsive.getHorizontalPadding(context),
          right: Responsive.getHorizontalPadding(context),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight)
                    .withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight,
                  width: 1,
                ),
              ),
              child: CustomText(
                '${_currentImageIndex + 1}/${widget.imagePaths.length}',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMainImageViewer(ThemeProvider themeProvider) {
    return Container(
      height: Responsive.getValue(
        context,
        mobile: 400.0,
        tablet: 500.0,
        desktop: 600.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (themeProvider.isDarkMode
                    ? AppColors.primaryColor
                    : AppColors.primaryColorLight)
                .withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index) {
                return _buildImageItem(widget.imagePaths[index], themeProvider);
              },
            ),
            if (widget.imagePaths.length > 1) ...[
              _buildNavigationButton(
                alignment: Alignment.centerLeft,
                icon: Icons.chevron_left_rounded,
                onTap: () {
                  if (_currentImageIndex > 0) {
                    _navigateToImage(_currentImageIndex - 1);
                  }
                },
                themeProvider: themeProvider,
              ),
              _buildNavigationButton(
                alignment: Alignment.centerRight,
                icon: Icons.chevron_right_rounded,
                onTap: () {
                  if (_currentImageIndex < widget.imagePaths.length - 1) {
                    _navigateToImage(_currentImageIndex + 1);
                  }
                },
                themeProvider: themeProvider,
              ),
            ],
            Positioned(
              top: 16,
              right: 16,
              child: _buildFullscreenButton(themeProvider),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(String imagePath, ThemeProvider themeProvider) {
    return GestureDetector(
      onTap: _toggleFullscreen,
      child: Container(
        decoration: BoxDecoration(
          gradient:
              themeProvider.isDarkMode
                  ? AppColors.backgroundGradient
                  : AppColors.lightBackgroundGradient,
        ),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                gradient:
                    themeProvider.isDarkMode
                        ? AppColors.backgroundGradient
                        : AppColors.lightBackgroundGradient,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.image_not_supported_outlined,
                      size: 64,
                      color: (themeProvider.isDarkMode
                              ? AppColors.white
                              : AppColors.darkText)
                          .withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    CustomText(
                      'Image not found',
                      fontSize: 16,
                      color: (themeProvider.isDarkMode
                              ? AppColors.white
                              : AppColors.darkText)
                          .withOpacity(0.7),
                    ),
                    const SizedBox(height: 8),
                    CustomText(
                      imagePath,
                      fontSize: 12,
                      color: (themeProvider.isDarkMode
                              ? AppColors.white
                              : AppColors.darkText)
                          .withOpacity(0.5),
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

  Widget _buildNavigationButton({
    required Alignment alignment,
    required IconData icon,
    required VoidCallback onTap,
    required ThemeProvider themeProvider,
  }) {
    return Positioned.fill(
      child: Align(
        alignment: alignment,
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(30),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: (themeProvider.isDarkMode
                          ? Colors.black
                          : Colors.white)
                      .withOpacity(0.8),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: (themeProvider.isDarkMode
                            ? AppColors.primaryColor
                            : AppColors.primaryColorLight)
                        .withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFullscreenButton(ThemeProvider themeProvider) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: _toggleFullscreen,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: (themeProvider.isDarkMode ? Colors.black : Colors.white)
                .withOpacity(0.8),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: (themeProvider.isDarkMode
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight)
                  .withOpacity(0.3),
            ),
          ),
          child: Icon(
            Icons.fullscreen,
            color:
                themeProvider.isDarkMode
                    ? AppColors.primaryColor
                    : AppColors.primaryColorLight,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildImageThumbnails(ThemeProvider themeProvider) {
    final crossAxisCount = Responsive.getValue(
      context,
      mobile: 3,
      tablet: 4,
      desktop: 6,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'All Images',
          fontSize: Responsive.getFontSize(context, mobile: 18, desktop: 22),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ),
        SizedBox(height: Responsive.getSpacing(context)),
        AnimationLimiter(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: Responsive.getSpacing(context, multiplier: 0.5),
              mainAxisSpacing: Responsive.getSpacing(context, multiplier: 0.5),
              childAspectRatio: 0.7,
            ),
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredGrid(
                position: index,
                duration: const Duration(milliseconds: 375),
                columnCount: crossAxisCount,
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildThumbnail(index, themeProvider),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildThumbnail(int index, ThemeProvider themeProvider) {
    final isSelected = index == _currentImageIndex;

    return GestureDetector(
      onTap: () => _navigateToImage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? (themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight)
                    : Colors.transparent,
            width: 3,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: (themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight)
                    .withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(9),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient:
                      themeProvider.isDarkMode
                          ? AppColors.backgroundGradient
                          : AppColors.lightBackgroundGradient,
                ),
                child: Image.asset(
                  widget.imagePaths[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient:
                            themeProvider.isDarkMode
                                ? AppColors.backgroundGradient
                                : AppColors.lightBackgroundGradient,
                      ),
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported,
                          color: (themeProvider.isDarkMode
                                  ? AppColors.white
                                  : AppColors.darkText)
                              .withOpacity(0.5),
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (isSelected)
                Container(
                  decoration: BoxDecoration(
                    color: (themeProvider.isDarkMode
                            ? AppColors.primaryColor
                            : AppColors.primaryColorLight)
                        .withOpacity(0.2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.check_circle,
                      color:
                          themeProvider.isDarkMode
                              ? AppColors.primaryColor
                              : AppColors.primaryColorLight,
                      size: 32,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    ).animate().scale(delay: Duration(milliseconds: index * 50));
  }

  Widget _buildFullscreenView(ThemeProvider themeProvider) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
              itemCount: widget.imagePaths.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                  panEnabled: true,
                  boundaryMargin: const EdgeInsets.all(20),
                  minScale: 0.5,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.asset(
                      widget.imagePaths[index],
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_outlined,
                                size: 64,
                                color: Colors.white54,
                              ),
                              SizedBox(height: 16),
                              CustomText(
                                'Image not found',
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: _toggleFullscreen,
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      '${_currentImageIndex + 1} / ${widget.imagePaths.length}',
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
