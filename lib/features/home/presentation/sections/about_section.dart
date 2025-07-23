import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/shared/floating_image.dart';
import 'package:my_portfolio/core/shared/section_wrapper.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'about',
      globalKey: PortfolioScrollController.sectionKeys['about'],
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),

          _buildProfileImage(),
          const SizedBox(height: 30),
          _buildTextContent(),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: _buildTextContent()),
          const SizedBox(width: 60),
          Expanded(flex: 1, child: Center(child: _buildProfileImage())),
        ],
      );
    }
  }

  Widget _buildProfileImage() {
    return const FloatingImage(
      imagePath: "assets/images/myImage.jpg",
      radius: 120,
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          "Mohamed Amr Ibrahim",
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 8),
        _buildAnimatedText(),
        const SizedBox(height: 16),
        const CustomText(
          'Based in Alexandria, Egypt',
          fontSize: 16.0,
          color: Color(0xff9CABBA),
          fontWeight: FontWeight.w500,
        ),
        const SizedBox(height: 24),
        CustomText(
          "Flutter Developer specializing in Dart, Flutter, and Firebase, with experience in building scalable, \nhigh-performance mobile and web applications. \nStrong foundation in modern development practices and cross-platform solutions.",
          fontSize: 16,
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.left,
          color: AppColors.white.withOpacity(0.8),
        ),
      ],
    );
  }

  Widget _buildAnimatedText() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 18.0,
        color: AppColors.white,
        fontFamily: 'SpaceGrotesk',
        fontWeight: FontWeight.w500,
      ),
      child: AnimatedTextKit(
        totalRepeatCount: 1,
        repeatForever: false,
        animatedTexts: [
          TypewriterAnimatedText(
            'Flutter Developer',
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Bachelor\'s Degree in Computer Science',
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Cross Platform Mobile Application Development',
            speed: const Duration(milliseconds: 100),
          ),
          TypewriterAnimatedText(
            'Flutter Developer',
            speed: const Duration(milliseconds: 100),
          ),
        ],
      ),
    );
  }
}
