import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:provider/provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  // Helper method to calculate experience duration
  String _calculateDuration(String period) {
    try {
      final parts = period.split(' - ');
      if (parts.length != 2) return period;

      final startDate = _parseDate(parts[0]);
      final endDate =
          parts[1].toLowerCase() == 'present'
              ? DateTime.now()
              : _parseDate(parts[1]);

      if (startDate == null || endDate == null) return period;

      final difference = endDate.difference(startDate);
      final months = (difference.inDays / 30).round();

      if (months < 1) {
        return '${difference.inDays} days';
      } else if (months < 12) {
        return '$months ${months == 1 ? 'month' : 'months'}';
      } else {
        final years = (months / 12).floor();
        final remainingMonths = months % 12;
        if (remainingMonths == 0) {
          return '$years ${years == 1 ? 'year' : 'years'}';
        } else {
          return '$years ${years == 1 ? 'year' : 'years'}, $remainingMonths ${remainingMonths == 1 ? 'month' : 'months'}';
        }
      }
    } catch (e) {
      return period;
    }
  }

  DateTime? _parseDate(String dateStr) {
    try {
      final months = {
        'Jan': 1,
        'Feb': 2,
        'Mar': 3,
        'Apr': 4,
        'May': 5,
        'Jun': 6,
        'Jul': 7,
        'Aug': 8,
        'Sep': 9,
        'Oct': 10,
        'Nov': 11,
        'Dec': 12,
      };

      final parts = dateStr.trim().split(' ');
      if (parts.length != 2) return null;

      final month = months[parts[0]];
      final year = int.tryParse(parts[1]);

      if (month == null || year == null) return null;

      return DateTime(year, month);
    } catch (e) {
      return null;
    }
  }

  // Get experience status based on end date
  String _getExperienceStatus(String period) {
    if (period.toLowerCase().contains('present')) {
      return 'Current';
    } else {
      final parts = period.split(' - ');
      if (parts.length == 2) {
        final endDate = _parseDate(parts[1]);
        if (endDate != null) {
          final now = DateTime.now();
          final monthsAgo = (now.difference(endDate).inDays / 30).round();

          if (monthsAgo < 6) {
            return 'Recent';
          } else if (monthsAgo < 12) {
            return 'Past Year';
          } else {
            return 'Completed';
          }
        }
      }
    }
    return 'Completed';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Current':
        return Colors.green;
      case 'Recent':
        return Colors.orange;
      case 'Past Year':
        return Colors.blue;
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'experience',
      globalKey: PortfolioScrollController.sectionKeys['experience'],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          final textColor =
              themeProvider.isDarkMode ? AppColors.white : AppColors.black;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildSectionTitle(textColor),
              const SizedBox(height: 40),
              _buildExperienceList(context, themeProvider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(Color textColor) {
    return CustomText(
      "Experience",
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: textColor,
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
  }

  Widget _buildExperienceList(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final experiences = [
      {
        'title': 'Flutter Developer Freelancer',
        'company': 'Freelance',
        'period': 'Mar 2025 - Present',
        'description':
            'Updated and refactored a 5-year-old school management app to support modern Flutter dependencies. \nDebugged critical errors, resolved package conflicts, and improved app stability. \nAudited Firebase integration and suggested major fixes. \nMaintained client communication to align on major changes.',
        'technologies': [
          'Flutter',
          'Dart',
          'Firebase',
          'Git',
          'Debugging',
          'Legacy Code',
        ],
        'achievements': [
          'Reduced app crash rate by 85%',
          'Updated 15+ deprecated packages',
          'Improved app loading time by 40%',
        ],
      },
      {
        'title': 'Mobile App Development Intern',
        'company': 'The Digital Egypt Pioneers Initiative (DEPI)',
        'period': 'Oct 2024 - May 2025',
        'description':
            'Assisted in developing mobile applications and learned modern development practices. Contributed to UI/UX improvements and bug fixes. Worked on cross-platform mobile solutions using Flutter framework.',
        'technologies': ['Flutter', 'Dart', 'Kotlin', 'Java', 'GitHub'],
        'achievements': [
          'Contributed to 3 major projects',
          'Fixed 25+ UI/UX issues',
          'Implemented responsive design patterns',
        ],
      },
      {
        'title': 'Flutter Development Intern',
        'company': 'ACM',
        'period': 'Aug 2024 - Oct 2024',
        'description':
            'Assisted in developing Flutter applications and learned modern development practices. Gained hands-on experience with state management and API integration.',
        'technologies': ['Flutter', 'Dart', 'Firebase'],
        'achievements': [
          'Built 2 complete mobile apps',
          'Learned GoogleMap pattern implementation',
          'Integrated REST APIs successfully',
        ],
      },
    ];

    return Column(
      children:
          experiences.asMap().entries.map((entry) {
            final index = entry.key;
            final experience = entry.value;
            return _buildExperienceCard(
              experience,
              index,
              context,
              themeProvider,
            );
          }).toList(),
    );
  }

  Widget _buildExperienceCard(
    Map<String, dynamic> experience,
    int index,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    final duration = _calculateDuration(experience['period']);
    final status = _getExperienceStatus(experience['period']);
    final statusColor = _getStatusColor(status);
    final textColor =
        themeProvider.isDarkMode ? AppColors.white : AppColors.black;
    final subTextColor =
        themeProvider.isDarkMode
            ? AppColors.white.withOpacity(0.8)
            : AppColors.black.withOpacity(0.8);
    final faintTextColor =
        themeProvider.isDarkMode
            ? AppColors.white.withOpacity(0.7)
            : AppColors.black.withOpacity(0.7);

    return Container(
          margin: const EdgeInsets.only(bottom: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: (themeProvider.isDarkMode
                    ? AppColors.buttonColorDark
                    : AppColors.cardLight)
                .withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: (themeProvider.isDarkMode
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight)
                  .withOpacity(0.2),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: statusColor.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          experience['title'],
                          fontSize: Responsive.isMobile(context) ? 16 : 20,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                        const SizedBox(height: 4),
                        CustomText(
                          experience['company'],
                          fontSize: Responsive.isMobile(context) ? 12 : 16,
                          fontWeight: FontWeight.w500,
                          color:
                              themeProvider.isDarkMode
                                  ? AppColors.primaryColor.withOpacity(0.3)
                                  : AppColors.buttonColorDark,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Status Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor.withOpacity(0.4),
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
                                color: statusColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 4),
                            CustomText(
                              status,
                              fontSize: Responsive.isMobile(context) ? 8 : 10,
                              fontWeight: FontWeight.w600,
                              color: statusColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Period Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeProvider.isDarkMode
                                  ? AppColors.primaryColor.withOpacity(0.3)
                                  : AppColors.buttonColorDark,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CustomText(
                          experience['period'],
                          fontSize: Responsive.isMobile(context) ? 8 : 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Duration Chip
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              themeProvider.isDarkMode
                                  ? AppColors.buttonColorDark.withOpacity(0.6)
                                  : AppColors.cardLight.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: CustomText(
                          duration,
                          fontSize: Responsive.isMobile(context) ? 7 : 9,
                          fontWeight: FontWeight.w400,
                          color: faintTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              CustomText(
                experience['description'],
                fontSize: Responsive.isMobile(context) ? 11 : 14,
                fontWeight: FontWeight.w400,
                color: subTextColor,
              ),

              // Achievements (if available)
              if (experience['achievements'] != null) ...[
                const SizedBox(height: 16),
                CustomText(
                  'Key Achievements:',
                  fontSize: Responsive.isMobile(context) ? 10 : 12,
                  fontWeight: FontWeight.w600,
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor.withOpacity(0.3)
                          : AppColors.buttonColorDark,
                ),
                const SizedBox(height: 8),
                ...((experience['achievements'] as List<String>).map((
                  achievement,
                ) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 6, right: 8),
                          decoration: BoxDecoration(
                            color:
                                themeProvider.isDarkMode
                                    ? AppColors.primaryColor.withOpacity(0.3)
                                    : AppColors.buttonColorDark,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: CustomText(
                            achievement,
                            fontSize: Responsive.isMobile(context) ? 9 : 12,
                            fontWeight: FontWeight.w400,
                            color: faintTextColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),
              ],

              const SizedBox(height: 16),

              // Technologies
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    (experience['technologies'] as List<String>)
                        .map((tech) => _buildTechChip(tech, themeProvider))
                        .toList(),
              ),
            ],
          ),
        )
        .animate(delay: (index * 200).ms)
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.3);
  }

  Widget _buildTechChip(String technology, ThemeProvider themeProvider) {
    final textColor =
        themeProvider.isDarkMode
            ? AppColors.white.withOpacity(0.9)
            : AppColors.black.withOpacity(0.9);
    final bgColor =
        themeProvider.isDarkMode
            ? AppColors.buttonColorDark
            : AppColors.buttonColorLight;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              themeProvider.isDarkMode
                  ? AppColors.primaryColor.withOpacity(0.3)
                  : AppColors.buttonColorDark,
          width: 0.5,
        ),
      ),
      child: CustomText(
        technology,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}
