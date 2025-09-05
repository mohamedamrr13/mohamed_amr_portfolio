import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:provider/provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'skills',
      globalKey: PortfolioScrollController.sectionKeys['skills'],
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
          _buildSkillsContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CustomText(
          "Skills & Technologies",
          fontSize: Responsive.getFontSize(context, mobile: 28, desktop: 36),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildSkillsContent(BuildContext context) {
    final skillCategories = [
      {
        'category': 'Mobile Development',
        'skills': ['Flutter', 'Dart', 'Android', 'iOS', 'Cross-platform'],
        'color': const Color(0xFF2196F3),
        'icon': Icons.phone_android_rounded,
        'description': 'Building beautiful cross-platform mobile applications',
      },
      {
        'category': 'AI & Modern Tools',
        'skills': ['Docker', 'Whisper APIs', 'Dialog Flow', 'Gemini APIs'],
        'color': const Color(0xFFFF9800),
        'icon': Icons.smart_toy_rounded,
        'description':
            'Integrating AI capabilities and modern development tools',
      },
      {
        'category': 'Backend & Development',
        'skills': [
          'Git',
          'REST APIs',
          'Firebase',
          'SQLite',
          'Provider',
          'BLoC',
          'Postman',
        ],
        'color': const Color(0xFF4CAF50),
        'icon': Icons.storage_rounded,
        'description': 'Full-stack development and database management',
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 400),
          childAnimationBuilder:
              (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
          children:
              skillCategories.asMap().entries.map((entry) {
                final index = entry.key;
                final category = entry.value;
                return _buildSkillCategory(category, context, index);
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(
    Map<String, dynamic> category,
    BuildContext context,
    int index,
  ) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final categoryColor = category['color'] as Color;

        return Container(
              margin: EdgeInsets.only(
                bottom: Responsive.getSpacing(context, multiplier: 1.5),
              ),
              padding: EdgeInsets.all(
                Responsive.getSpacing(context, multiplier: 1.5),
              ),
              decoration: BoxDecoration(
                color: (themeProvider.isDarkMode
                        ? AppColors.buttonColorDark
                        : AppColors.cardLight)
                    .withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: categoryColor.withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: categoryColor.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategoryHeader(category, context, themeProvider),
                  SizedBox(height: Responsive.getSpacing(context)),
                  _buildCategoryDescription(category, context, themeProvider),
                  SizedBox(
                    height: Responsive.getSpacing(context, multiplier: 1.2),
                  ),
                  _buildSkillChips(category, context, themeProvider),
                ],
              ),
            )
            .animate(delay: Duration(milliseconds: index * 150))
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3);
      },
    );
  }

  Widget _buildCategoryHeader(
    Map<String, dynamic> category,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final categoryColor = category['color'] as Color;

    return Responsive.responsive(
      context,
      mobile: _buildMobileCategoryHeader(category, context, themeProvider),
      desktop: _buildDesktopCategoryHeader(category, context, themeProvider),
    );
  }

  Widget _buildMobileCategoryHeader(
    Map<String, dynamic> category,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final categoryColor = category['color'] as Color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildCategoryIcon(category, context),
            SizedBox(width: Responsive.getSpacing(context, multiplier: 0.75)),
            Expanded(
              child: CustomText(
                category['category'] as String,
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 18,
                  desktop: 20,
                ),
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.white
                        : AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopCategoryHeader(
    Map<String, dynamic> category,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Row(
      children: [
        _buildCategoryIcon(category, context),
        SizedBox(width: Responsive.getSpacing(context)),
        Expanded(
          child: CustomText(
            category['category'] as String,
            fontSize: Responsive.getFontSize(context, mobile: 18, desktop: 22),
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(
    Map<String, dynamic> category,
    BuildContext context,
  ) {
    final categoryColor = category['color'] as Color;

    return Container(
      padding: EdgeInsets.all(Responsive.getSpacing(context, multiplier: 0.75)),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: categoryColor.withOpacity(0.3), width: 1),
      ),
      child: Icon(
        category['icon'] as IconData,
        color: categoryColor,
        size: Responsive.getIconSize(context, multiplier: 1.2),
      ),
    );
  }

  Widget _buildCategoryDescription(
    Map<String, dynamic> category,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return CustomText(
      category['description'] as String,
      fontSize: Responsive.getFontSize(context, mobile: 14, desktop: 16),
      fontWeight: FontWeight.w400,
      color: (themeProvider.isDarkMode ? AppColors.white : AppColors.darkText)
          .withOpacity(0.7),
    );
  }

  Widget _buildSkillChips(
    Map<String, dynamic> category,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final skills = category['skills'] as List<String>;
    final categoryColor = category['color'] as Color;

    return Wrap(
      spacing: Responsive.getSpacing(context, multiplier: 0.5),
      runSpacing: Responsive.getSpacing(context, multiplier: 0.5),
      children:
          skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;

            return _SkillChip(
              skill: skill,
              color: categoryColor,
              index: index,
              themeProvider: themeProvider,
            );
          }).toList(),
    );
  }
}

class _SkillChip extends StatefulWidget {
  final String skill;
  final Color color;
  final int index;
  final ThemeProvider themeProvider;

  const _SkillChip({
    required this.skill,
    required this.color,
    required this.index,
    required this.themeProvider,
  });

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(begin: 0.0, end: 8.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _borderAnimation = Tween<double>(begin: 0.3, end: 0.6).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    if (!Responsive.isMobile(context)) {
      setState(() => _isHovered = hovering);
      if (hovering) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          cursor: SystemMouseCursors.click,
          child: AnimatedBuilder(
            animation: _hoverController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.getSpacing(
                      context,
                      multiplier: 0.75,
                    ),
                    vertical: Responsive.getSpacing(context, multiplier: 0.5),
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(_isHovered ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: widget.color.withOpacity(_borderAnimation.value),
                      width: _isHovered ? 1.5 : 1,
                    ),
                    boxShadow:
                        _isHovered
                            ? [
                              BoxShadow(
                                color: widget.color.withOpacity(0.2),
                                blurRadius: _elevationAnimation.value,
                                offset: Offset(
                                  0,
                                  _elevationAnimation.value * 0.3,
                                ),
                              ),
                            ]
                            : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Responsive.isMobile(context) ? 5 : 6,
                        height: Responsive.isMobile(context) ? 5 : 6,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: Responsive.getSpacing(
                          context,
                          multiplier: 0.375,
                        ),
                      ),
                      CustomText(
                        widget.skill,
                        fontSize: Responsive.getFontSize(
                          context,
                          mobile: 12,
                          desktop: 13,
                        ),
                        fontWeight: FontWeight.w500,
                        color: widget.color,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        )
        .animate(delay: Duration(milliseconds: widget.index * 80))
        .fadeIn(duration: 400.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}
