import 'package:flutter/material.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';
import 'package:my_portfolio/features/home/presentation/sections/about_section.dart';
import 'package:my_portfolio/features/home/presentation/sections/contact_section.dart';
import 'package:my_portfolio/features/home/presentation/sections/experience_section.dart';
import 'package:my_portfolio/features/home/presentation/sections/projects_section.dart';
import 'package:my_portfolio/features/home/presentation/sections/skills_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: PortfolioScrollController.scrollController,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AboutSection(),
          SizedBox(height: 60),
          ExperienceSection(),
          SizedBox(height: 60),
          ProjectsSection(),
          SizedBox(height: 60),
          SkillsSection(),
          SizedBox(height: 60),
          ContactSection(),
          SizedBox(height: 40),
     
        ],
      ),
    );
  }
}
