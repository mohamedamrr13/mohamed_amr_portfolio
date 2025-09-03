import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/floating_image.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';

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
          SizedBox(height: Responsive.isMobile(context) ? 90 : 140),

          _buildProfileImage(),
          const SizedBox(height: 30),
          _buildTextContent(context),
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: _buildTextContent(context)),
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

  Widget _buildTextContent(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              "Mohamed Amr Ibrahim",
              fontSize: Responsive.isMobile(context) ? 26 : 32,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 8),
            _buildAnimatedText(themeProvider),
            const SizedBox(height: 16),
            CustomText(
              'Based in Alexandria, Egypt',
              fontSize: 16.0,
              color:
                  themeProvider.isDarkMode
                      ? const Color(0xff9CABBA)
                      : AppColors.lightText,
              fontWeight: FontWeight.w500,
            ),
            const SizedBox(height: 24),
            CustomText(
              "Flutter Developer specializing in Dart, Flutter, and Firebase, with experience in building scalable, high-performance mobile and web applications. Strong foundation in modern development practices and cross-platform solutions.",
              fontSize: 16,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.left,
              color: (themeProvider.isDarkMode
                      ? AppColors.white
                      : AppColors.darkText)
                  .withOpacity(0.8),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAnimatedText(ThemeProvider themeProvider) {
    return DefaultTextStyle(
      style: TextStyle(
        fontSize: 18.0,
        color: themeProvider.isDarkMode ? AppColors.white : AppColors.darkText,
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
