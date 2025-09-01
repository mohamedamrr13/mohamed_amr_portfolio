import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'contact',
      globalKey: PortfolioScrollController.sectionKeys['contact'],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle(),
          const SizedBox(height: 40),
          _buildContactContent(context),
          const SizedBox(height: 40),

          Center(
            child: DefaultTextStyle(
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 12 : 18,
                color: AppColors.grey,
                fontFamily: 'SpaceGrotesk',
              ),
              child: AnimatedTextKit(
                isRepeatingAnimation: false,
                repeatForever: false,
                animatedTexts: [
                  WavyAnimatedText(
                    '©2025 Mohamed Amr, All Rights Reserved.',
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle() {
    return const CustomText(
      "Contact",
      fontSize: 28,
      fontWeight: FontWeight.bold,
    ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
  }

  Widget _buildContactContent(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.isMobile(context) ? 16 : 32),
      decoration: BoxDecoration(
        color: AppColors.buttonColorDark.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            "Let's work together!",
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 16),
          CustomText(
            "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision. Feel free to reach out via my social media profiles. View my CV for more details about my experience.",
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.8),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset('assets/jsons/online_animation.json', height: 35),
                const SizedBox(width: 5),
                CustomText(
                  maxLines: 2,
                  "Currently available for new opportunities.",
                  fontSize: Responsive.isMobile(context) ? 10 : 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.green,
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSocialLinks(context),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3);
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = [
      // {
      //   'name': 'LinkedIn',
      //   'icon': 'assets/images/linkedin.svg',
      //   'url': 'https://www.linkedin.com/in/mohamed-amr-667749222/',
      // },
      {
        'name': 'GitHub',
        'icon': 'assets/images/github.svg',
        'url': 'https://github.com/mohamedamrr13',
      },
      // {
      //   'name': 'Email',
      //   'icon': 'assets/images/mail.svg',
      //   'url': 'mailto:mohamed.egypt140@gmail.com',
      // },
      {
        'name': 'Upwork',
        'icon': 'assets/images/upwork.svg',
        'url': 'https://www.upwork.com/freelancers/~012448ab74e4f83791',
      },
    ];

    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        children: socialLinks.map((link) => _buildSocialButton(link)).toList(),
      );
    } else {
      return Row(
        children:
            socialLinks
                .map((link) => Expanded(child: _buildSocialButton(link)))
                .toList(),
      );
    }
  }

  Widget _buildSocialButton(Map<String, String> link) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _launchUrl(link['url']!),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.buttonColorDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  link['icon']!,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                const SizedBox(width: 8),
                CustomText(
                  link['name']!,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
