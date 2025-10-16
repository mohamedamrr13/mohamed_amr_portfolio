import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/about_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/contact_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/experience_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/projects_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/skills_section.dart';
import 'package:mohamed_amr_portfolio/portfolio_config.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key, this.config = const PortfolioConfig()});
  final PortfolioConfig config;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: PortfolioScrollController.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AboutSection(show: config.showContact),
          SizedBox(height: Responsive.isMobile(context) ? 0 : 60),
          const ExperienceSection(),
          const ProjectsSection(),
          const SkillsSection(),
          if (config.showContact) ContactSection(),
        ],
      ),
    );
  }
}
