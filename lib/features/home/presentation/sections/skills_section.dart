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

  // Helper method to get responsive font sizes
  double _getResponsiveFontSize(BuildContext context, double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.8; // 80% on mobile
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

  double _getResponsiveIconSize(BuildContext context, double baseSize) {
    if (Responsive.isMobile(context)) {
      return baseSize * 0.85; // 85% on mobile
    } else if (Responsive.isTablet(context)) {
      return baseSize * 0.9; // 90% on tablet
    }
    return baseSize; // Full size on desktop
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'skills',
      globalKey: PortfolioScrollController.sectionKeys['skills'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: _getResponsivePadding(context, 20)),
          _buildSectionTitle(context),
          SizedBox(height: _getResponsivePadding(context, 40)),
          _buildSkillsContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final textColor =
            themeProvider.isDarkMode ? AppColors.white : AppColors.black;
        return CustomText(
          "Skills & Technologies",
          fontSize: _getResponsiveFontSize(context, 28),
          fontWeight: FontWeight.bold,
          color: textColor,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildSkillsContent(BuildContext context) {
    final skillCategories = [
      {
        'category': 'Mobile Development',
        'skills': ['Flutter', 'Dart', 'Android', 'iOS', 'Cross-platform'],
        'color': Colors.blue,
        'icon': Icons.phone_android,
      },
      {
        'category': 'AI Tools',
        'skills': ['Docker', 'Whisper APIs', 'Dialog Flow', 'Gemini APIs'],
        'color': Colors.orange,
        'icon': Icons.smart_toy,
      },
      {
        'category': 'Backend & Tools',
        'skills': [
          'Git',
          'REST APIs',
          'Firebase',
          'SQLite',
          'Provider',
          'BLoC',
          'Postman',
        ],
        'color': Colors.green,
        'icon': Icons.storage,
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 300),
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
        final textColor =
            themeProvider.isDarkMode ? AppColors.white : AppColors.black;

        return Container(
              margin: EdgeInsets.only(
                bottom: _getResponsivePadding(context, 24),
              ),
              padding: EdgeInsets.all(_getResponsivePadding(context, 20)),
              decoration: BoxDecoration(
                color: (themeProvider.isDarkMode
                        ? AppColors.buttonColorDark
                        : AppColors.cardLight)
                    .withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (category['color'] as Color).withOpacity(0.3),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (category['color'] as Color).withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Row - Stack on mobile for better space usage
                  if (Responsive.isMobile(context)) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(
                                _getResponsivePadding(context, 8),
                              ),
                              decoration: BoxDecoration(
                                color: (category['color'] as Color).withOpacity(
                                  0.2,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                category['icon'] as IconData,
                                color: category['color'] as Color,
                                size: _getResponsiveIconSize(context, 18),
                              ),
                            ),
                            SizedBox(width: _getResponsivePadding(context, 12)),
                            Expanded(
                              child: CustomText(
                                category['category'] as String,
                                fontSize: _getResponsiveFontSize(context, 16),
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: _getResponsivePadding(context, 8)),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _getResponsivePadding(context, 8),
                            vertical: _getResponsivePadding(context, 4),
                          ),
                          decoration: BoxDecoration(
                            color: (category['color'] as Color).withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomText(
                            '${(category['skills'] as List).length} skills',
                            fontSize: _getResponsiveFontSize(context, 9),
                            fontWeight: FontWeight.w500,
                            color: category['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(
                            _getResponsivePadding(context, 8),
                          ),
                          decoration: BoxDecoration(
                            color: (category['color'] as Color).withOpacity(
                              0.2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            category['icon'] as IconData,
                            color: category['color'] as Color,
                            size: _getResponsiveIconSize(context, 20),
                          ),
                        ),
                        SizedBox(width: _getResponsivePadding(context, 12)),
                        Expanded(
                          child: CustomText(
                            category['category'] as String,
                            fontSize: _getResponsiveFontSize(context, 18),
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: _getResponsivePadding(context, 8),
                            vertical: _getResponsivePadding(context, 4),
                          ),
                          decoration: BoxDecoration(
                            color: (category['color'] as Color).withOpacity(
                              0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: CustomText(
                            '${(category['skills'] as List).length} skills',
                            fontSize: _getResponsiveFontSize(context, 10),
                            fontWeight: FontWeight.w500,
                            color: category['color'] as Color,
                          ),
                        ),
                      ],
                    ),
                  ],

                  SizedBox(height: _getResponsivePadding(context, 16)),
                  _buildSkillChips(
                    category['skills'] as List<String>,
                    category['color'] as Color,
                    context,
                  ),
                ],
              ),
            )
            .animate(delay: Duration(milliseconds: index * 100))
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.2, end: 0);
      },
    );
  }

  Widget _buildSkillChips(
    List<String> skills,
    Color color,
    BuildContext context,
  ) {
    return Wrap(
      spacing: Responsive.isMobile(context) ? 6 : 8,
      runSpacing: Responsive.isMobile(context) ? 6 : 8,
      children:
          skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;

            return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _getResponsivePadding(context, 12),
                    vertical: _getResponsivePadding(context, 8),
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color.withOpacity(0.3), width: 1),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Responsive.isMobile(context) ? 5 : 6,
                        height: Responsive.isMobile(context) ? 5 : 6,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: _getResponsivePadding(context, 6)),
                      CustomText(
                        skill,
                        fontSize: _getResponsiveFontSize(context, 12),
                        fontWeight: FontWeight.w500,
                        color: color,
                      ),
                    ],
                  ),
                )
                .animate(delay: Duration(milliseconds: index * 50))
                .fadeIn(duration: 300.ms)
                .scale(begin: const Offset(0.8, 0.8));
          }).toList(),
    );
  }

  // Enhanced interactive skill chips with hover effects
  Widget _buildInteractiveSkillChips(
    List<String> skills,
    Color color,
    BuildContext context,
  ) {
    return Wrap(
      spacing: Responsive.isMobile(context) ? 6 : 8,
      runSpacing: Responsive.isMobile(context) ? 6 : 8,
      children:
          skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;

            return _SkillChipHoverable(
              skill: skill,
              color: color,
              index: index,
              context: context,
              getResponsiveFontSize: _getResponsiveFontSize,
              getResponsivePadding: _getResponsivePadding,
            );
          }).toList(),
    );
  }
}

// Separate hoverable skill chip widget for better performance
class _SkillChipHoverable extends StatefulWidget {
  final String skill;
  final Color color;
  final int index;
  final BuildContext context;
  final Function getResponsiveFontSize;
  final Function getResponsivePadding;

  const _SkillChipHoverable({
    required this.skill,
    required this.color,
    required this.index,
    required this.context,
    required this.getResponsiveFontSize,
    required this.getResponsivePadding,
  });

  @override
  State<_SkillChipHoverable> createState() => _SkillChipHoverableState();
}

class _SkillChipHoverableState extends State<_SkillChipHoverable>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutQuart),
    );

    _elevationAnimation = Tween<double>(begin: 0.0, end: 4.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutQuart),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    if (!Responsive.isMobile(widget.context)) {
      setState(() {
        _isHovered = hovering;
      });

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
          onEnter: (_) => _onHover(true),
          onExit: (_) => _onHover(false),
          cursor: SystemMouseCursors.click,
          child: AnimatedBuilder(
            animation: _hoverController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.getResponsivePadding(
                      widget.context,
                      12.0,
                    ),
                    vertical: widget.getResponsivePadding(widget.context, 8.0),
                  ),
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(_isHovered ? 0.15 : 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: widget.color.withOpacity(_isHovered ? 0.5 : 0.3),
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
                                  _elevationAnimation.value * 0.5,
                                ),
                              ),
                            ]
                            : null,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: Responsive.isMobile(widget.context) ? 5 : 6,
                        height: Responsive.isMobile(widget.context) ? 5 : 6,
                        decoration: BoxDecoration(
                          color: widget.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(
                        width: widget.getResponsivePadding(widget.context, 6.0),
                      ),
                      CustomText(
                        widget.skill,
                        fontSize: widget.getResponsiveFontSize(
                          widget.context,
                          12.0,
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
        .animate(delay: Duration(milliseconds: widget.index * 50))
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }
}
