import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';

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
      },
      {
        'category': 'AI Tools',
        'skills': ['Docker', 'Whisper APIs', 'Dialog Flow', 'Gemini APIs'],
        'color': Colors.orange,
      },
      {
        'category': 'Version Control & Backend',
        'skills': [
          'Git',
          'Rest APIs',
          'Firebase',
          'SQLite',
          'Provider',
          'Bloc',
          'Postman',
        ],
        'color': Colors.green,
      },
    ];

    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 200),
          childAnimationBuilder:
              (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
          children:
              skillCategories.map((category) {
                return _buildSkillCategory(category, context);
              }).toList(),
        ),
      ),
    );
  }

  Widget _buildSkillCategory(
    Map<String, dynamic> category,
    BuildContext context,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.buttonColorDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (category['color'] as Color).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 20,
                decoration: BoxDecoration(
                  color: category['color'],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                category['category'],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSkillChips(category['skills'], category['color']),
        ],
      ),
    );
  }

  Widget _buildSkillChips(List<String> skills, Color color) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children:
          skills.map((skill) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: CustomText(
                skill,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: color,
              ),
            );
          }).toList(),
    );
  }
}
