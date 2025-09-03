import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:provider/provider.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'skills',
      globalKey: PortfolioScrollController.sectionKeys['skills'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          _buildSectionTitle(),
          const SizedBox(height: 40),
          _buildSkillsContent(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const CustomText(
      "Skills & Technologies",
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
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
        return Container(
              margin: const EdgeInsets.only(bottom: 24),
              padding: const EdgeInsets.all(20),
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
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: (category['color'] as Color).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: category['color'] as Color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomText(
                          category['category'] as String,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: (category['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomText(
                          '${(category['skills'] as List).length} skills',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: category['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildSkillChips(
                    category['skills'] as List<String>,
                    category['color'] as Color,
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

  Widget _buildSkillChips(List<String> skills, Color color) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;

            return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
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
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      CustomText(
                        skill,
                        fontSize: 12,
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

  // Alternative method for more interactive skill chips
  Widget _buildInteractiveSkillChips(List<String> skills, Color color) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills.asMap().entries.map((entry) {
            final index = entry.key;
            final skill = entry.value;

            return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: color.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        CustomText(
                          skill,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: color,
                        ),
                      ],
                    ),
                  ),
                )
                .animate(delay: Duration(milliseconds: index * 50))
                .fadeIn(duration: 300.ms)
                .scale(begin: const Offset(0.8, 0.8));
          }).toList(),
    );
  }
}
