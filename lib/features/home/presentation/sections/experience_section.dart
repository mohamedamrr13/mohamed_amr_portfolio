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

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'experience',
      globalKey: PortfolioScrollController.sectionKeys['experience'],
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
          _buildExperienceList(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CustomText(
          "Experience",
          fontSize: Responsive.getFontSize(context, mobile: 28, desktop: 36),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildExperienceList(BuildContext context) {
    final experiences = [
      {
        'title': 'Flutter Developer Freelancer',
        'company': 'Freelance',
        'period': 'Mar 2025 - Present',
        'description':
            'Updated and refactored a 5-year-old school management app to support modern Flutter dependencies. Debugged critical errors, resolved package conflicts, and improved app stability. Audited Firebase integration and suggested major fixes. Maintained client communication to align on major changes.',
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
          'Learned BLoC pattern implementation',
          'Integrated REST APIs successfully',
        ],
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
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        final duration = _calculateDuration(experience['period']);
        final status = _getExperienceStatus(experience['period']);
        final statusColor = _getStatusColor(status);

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
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight)
                      .withOpacity(0.2),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildExperienceHeader(
                    experience,
                    status,
                    statusColor,
                    duration,
                    context,
                    themeProvider,
                  ),
                  SizedBox(height: Responsive.getSpacing(context)),
                  _buildExperienceDescription(
                    experience,
                    context,
                    themeProvider,
                  ),
                  if (experience['achievements'] != null) ...[
                    SizedBox(height: Responsive.getSpacing(context)),
                    _buildAchievements(
                      experience['achievements'],
                      context,
                      themeProvider,
                    ),
                  ],
                  SizedBox(
                    height: Responsive.getSpacing(context, multiplier: 1.2),
                  ),
                  _buildTechnologies(
                    experience['technologies'],
                    context,
                    themeProvider,
                  ),
                ],
              ),
            )
            .animate(delay: Duration(milliseconds: index * 200))
            .fadeIn(duration: 600.ms)
            .slideY(begin: 0.3);
      },
    );
  }

  Widget _buildExperienceHeader(
    Map<String, dynamic> experience,
    String status,
    Color statusColor,
    String duration,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Responsive.responsive(
      context,
      mobile: _buildMobileHeader(
        experience,
        status,
        statusColor,
        duration,
        context,
        themeProvider,
      ),
      desktop: _buildDesktopHeader(
        experience,
        status,
        statusColor,
        duration,
        context,
        themeProvider,
      ),
    );
  }

  Widget _buildMobileHeader(
    Map<String, dynamic> experience,
    String status,
    Color statusColor,
    String duration,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          experience['title'],
          fontSize: Responsive.getFontSize(context, mobile: 18, desktop: 20),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ),
        SizedBox(height: Responsive.getSpacing(context, multiplier: 0.25)),
        CustomText(
          experience['company'],
          fontSize: Responsive.getFontSize(context, mobile: 14, desktop: 16),
          fontWeight: FontWeight.w600,
          color:
              themeProvider.isDarkMode
                  ? AppColors.primaryColor
                  : AppColors.primaryColorLight,
        ),
        SizedBox(height: Responsive.getSpacing(context, multiplier: 0.75)),
        Wrap(
          spacing: Responsive.getSpacing(context, multiplier: 0.5),
          runSpacing: Responsive.getSpacing(context, multiplier: 0.5),
          children: [
            _buildPeriodChip(experience['period'], themeProvider, context),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopHeader(
    Map<String, dynamic> experience,
    String status,
    Color statusColor,
    String duration,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                experience['title'],
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 18,
                  desktop: 22,
                ),
                fontWeight: FontWeight.bold,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.white
                        : AppColors.black,
              ),
              SizedBox(
                height: Responsive.getSpacing(context, multiplier: 0.25),
              ),
              CustomText(
                experience['company'],
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 14,
                  desktop: 16,
                ),
                fontWeight: FontWeight.w600,
                color:
                    themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
              ),
            ],
          ),
        ),
        SizedBox(width: Responsive.getSpacing(context)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildPeriodChip(experience['period'], themeProvider, context),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceDescription(
    Map<String, dynamic> experience,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return CustomText(
      experience['description'],
      fontSize: Responsive.getFontSize(context, mobile: 14, desktop: 16),
      fontWeight: FontWeight.w400,
      color: (themeProvider.isDarkMode ? AppColors.white : AppColors.darkText)
          .withOpacity(0.85),
    );
  }

  Widget _buildAchievements(
    List<String> achievements,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          'Key Achievements:',
          fontSize: Responsive.getFontSize(context, mobile: 12, desktop: 14),
          fontWeight: FontWeight.w600,
          color:
              themeProvider.isDarkMode
                  ? AppColors.primaryColor
                  : AppColors.primaryColorLight,
        ),
        SizedBox(height: Responsive.getSpacing(context, multiplier: 0.5)),
        ...achievements.map((achievement) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: Responsive.getSpacing(context, multiplier: 0.25),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4,
                  height: 4,
                  margin: EdgeInsets.only(
                    top: Responsive.getFontSize(context, mobile: 6, desktop: 8),
                    right: Responsive.getSpacing(context, multiplier: 0.5),
                  ),
                  decoration: BoxDecoration(
                    color:
                        themeProvider.isDarkMode
                            ? AppColors.primaryColor
                            : AppColors.primaryColorLight,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: CustomText(
                    achievement,
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 12,
                      desktop: 14,
                    ),
                    fontWeight: FontWeight.w400,
                    color: (themeProvider.isDarkMode
                            ? AppColors.white
                            : AppColors.darkText)
                        .withOpacity(0.7),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildTechnologies(
    List<String> technologies,
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Wrap(
      spacing: Responsive.getSpacing(context, multiplier: 0.5),
      runSpacing: Responsive.getSpacing(context, multiplier: 0.5),
      children:
          technologies.map((tech) {
            return Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.getSpacing(context, multiplier: 0.75),
                vertical: Responsive.getSpacing(context, multiplier: 0.5),
              ),
              decoration: BoxDecoration(
                color:
                    themeProvider.isDarkMode
                        ? AppColors.buttonColorDark
                        : AppColors.buttonColorLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor.withOpacity(0.3)
                          : AppColors.primaryColorLight.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: CustomText(
                tech,
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 11,
                  desktop: 12,
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


  Widget _buildPeriodChip(
    String period,
    ThemeProvider themeProvider,
    BuildContext context,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSpacing(context, multiplier: 0.75),
        vertical: Responsive.getSpacing(context, multiplier: 0.5),
      ),
      decoration: BoxDecoration(
        color:
            themeProvider.isDarkMode
                ? AppColors.primaryColor.withOpacity(0.2)
                : AppColors.primaryColorLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
              themeProvider.isDarkMode
                  ? AppColors.primaryColor.withOpacity(0.4)
                  : AppColors.primaryColorLight.withOpacity(0.4),
          width: 1,
        ),
      ),
      child: CustomText(
        period,
        fontSize: Responsive.getFontSize(context, mobile: 11, desktop: 12),
        fontWeight: FontWeight.w500,
        color:
            themeProvider.isDarkMode
                ? AppColors.primaryColor
                : AppColors.primaryColorLight,
      ),
    );
  }


  // Helper methods
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
}
