import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/shared/section_wrapper.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'experience',
      globalKey: PortfolioScrollController.sectionKeys['experience'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          _buildSectionTitle(),
          const SizedBox(height: 40),
          _buildExperienceList(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const CustomText(
      "Experience",
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
  }

  Widget _buildExperienceList(BuildContext context) {
    final experiences = [
      {
        'title': 'Flutter Developer Freelancer',
        'company': 'Freelance',
        'period': 'Mar 25 - Apr 25',
        'description':
            'Updated and refactored a 5-year-old school management app to support modern Flutter dependencies. \nDebugged critical errors, resolved package conflicts, and improved app stability. \nAudited Firebase integration and suggested major fixes. \nMaintained client communication to align on major changes. ',
        'technologies': [
          'Flutter',
          'Dart',
          'Firebase',
          'Git',
          'Debugging',
          'Legacy Code',
        ],
      },
      {
        'title': 'Mobile App Development Intern',
        'company': 'The Digital Egypt Pioneers Initiative (DEPI)',
        'period': 'Oct 24 - May 25',
        'description':
            'Assisted in developing mobile applications and learned modern development practices. Contributed to UI/UX improvements and bug fixes.',
        'technologies': ['Flutter', 'Dart', 'Kotlin', 'Java', 'GitHub'],
      },
    ];

    return Column(
      children:
          experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final experience = entry.value;
            return _buildExperienceCard(experience, index, context);
          }).toList(),
    );
  }

  Widget _buildExperienceCard(
    Map<String, dynamic> experience,
    int index,
    BuildContext context,
  ) {
    return Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.buttonColorDark.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          experience['title'],
                          fontSize: Responsive.isMobile(context) ? 14 : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          experience['company'],
                          fontSize: Responsive.isMobile(context) ? 10 : 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomText(
                      experience['period'],
                      fontSize: Responsive.isMobile(context) ? 7 : 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomText(
                experience['description'],
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.white.withOpacity(0.8),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    (experience['technologies'] as List<String>)
                        .map((tech) => _buildTechChip(tech))
                        .toList(),
              ),
            ],
          ),
        )
        .animate(delay: (index * 200).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3);
  }

  Widget _buildTechChip(String technology) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.buttonColorDark,
        borderRadius: BorderRadius.circular(16),
      ),
      child: CustomText(technology, fontSize: 12, fontWeight: FontWeight.w500),
    );
  }
}
