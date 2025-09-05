import 'package:flutter/material.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/about_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/contact_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/experience_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/projects_section.dart';
import 'package:mohamed_amr_portfolio/features/home/presentation/sections/skills_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: PortfolioScrollController.scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AboutSection(),
          SizedBox(height: Responsive.isMobile(context) ? 30 : 60),
          const ExperienceSection(),
          SizedBox(height: Responsive.isMobile(context) ? 30 : 60),
          const ProjectsSection(),
          SizedBox(height: Responsive.isMobile(context) ? 30 : 60),
          const SkillsSection(),
          SizedBox(height: Responsive.isMobile(context) ? 30 : 60),
          const ContactSection(),
        ],
      ),
    );
  }
}
