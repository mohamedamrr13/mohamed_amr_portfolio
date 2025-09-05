import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:mohamed_amr_portfolio/core/shared/custom_text.dart';
import 'package:mohamed_amr_portfolio/core/shared/section_wrapper.dart';
import 'package:mohamed_amr_portfolio/core/theming/app_colors.dart';
import 'package:mohamed_amr_portfolio/core/theming/theme_provider.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';
import 'package:mohamed_amr_portfolio/core/utils/scroll_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionWrapper(
      sectionKey: 'contact',
      globalKey: PortfolioScrollController.sectionKeys['contact'],
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
          _buildContactContent(context),
          SizedBox(height: Responsive.getSpacing(context, multiplier: 2.5)),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return CustomText(
          "Let's Connect",
          fontSize: Responsive.getFontSize(context, mobile: 28, desktop: 36),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3);
      },
    );
  }

  Widget _buildContactContent(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          padding: EdgeInsets.all(
            Responsive.getSpacing(context, multiplier: 2),
          ),
          decoration: BoxDecoration(
            color: (themeProvider.isDarkMode
                    ? AppColors.buttonColorDark
                    : AppColors.cardLight)
                .withOpacity(0.4),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: (themeProvider.isDarkMode
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight)
                  .withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContactHeader(context, themeProvider),
              SizedBox(height: Responsive.getSpacing(context, multiplier: 1.5)),
              _buildContactDescription(context, themeProvider),
              SizedBox(height: Responsive.getSpacing(context, multiplier: 1.5)),
              _buildAvailabilityStatus(context),
              SizedBox(height: Responsive.getSpacing(context, multiplier: 2)),
              _buildSocialLinks(context, themeProvider),
            ],
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.3);
      },
    );
  }

  Widget _buildContactHeader(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          "Ready to Work Together?",
          fontSize: Responsive.getFontSize(context, mobile: 22, desktop: 28),
          fontWeight: FontWeight.bold,
          color: themeProvider.isDarkMode ? AppColors.white : AppColors.black,
        ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
        SizedBox(height: Responsive.getSpacing(context, multiplier: 0.5)),
        Container(
          width: 60,
          height: 4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                themeProvider.isDarkMode
                    ? AppColors.primaryColor
                    : AppColors.primaryColorLight,
                themeProvider.isDarkMode
                    ? AppColors.primaryColor.withOpacity(0.3)
                    : AppColors.primaryColorLight.withOpacity(0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(2),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 600.ms).scaleX(),
      ],
    );
  }

  Widget _buildContactDescription(
    BuildContext context,
    ThemeProvider themeProvider,
  ) {
    return CustomText(
      "I'm always open to discussing new projects, creative ideas, or opportunities to be part of your vision. Whether you're looking to build something amazing from scratch or need help improving an existing project, I'd love to hear from you.",
      fontSize: Responsive.getFontSize(context, mobile: 16, desktop: 18),
      fontWeight: FontWeight.w400,
      color: (themeProvider.isDarkMode ? AppColors.white : AppColors.darkText)
          .withOpacity(0.85),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms);
  }

  Widget _buildAvailabilityStatus(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.getSpacing(context, multiplier: 1),
        vertical: Responsive.getSpacing(context, multiplier: 0.75),
      ),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: Responsive.getIconSize(context, multiplier: 1.5),
            height: Responsive.getIconSize(context, multiplier: 1.5),
            child: Lottie.asset(
              'assets/jsons/online_animation.json',
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: Responsive.getSpacing(context, multiplier: 0.5)),
          Flexible(
            child: CustomText(
              "Currently available for new opportunities",
              fontSize: Responsive.getFontSize(
                context,
                mobile: 12,
                desktop: 14,
              ),
              fontWeight: FontWeight.w600,
              color: Colors.green,
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1000.ms).scale();
  }

  Widget _buildSocialLinks(BuildContext context, ThemeProvider themeProvider) {
    final socialLinks = [
      {
        'name': 'CV',
        'icon': 'assets/images/cv.svg',
        'url':
            'https://drive.google.com/file/d/1tuucD62OP1-L5m7p9fIbJcIoj0uCBNha/view?usp=drivesdk',
        'description': 'View my resume',
      },
      {
        'name': 'Email',
        'icon': 'assets/images/mail.svg',
        'url': 'mailto:mohamed.egypt140@gmail.com',
        'description': 'Send me an email',
      },

      {
        'name': 'GitHub',
        'icon': 'assets/images/github.svg',
        'url': 'https://github.com/mohamedamrr13',
        'description': 'View my code',
      },
      {
        'name': 'LinkedIn',
        'icon': 'assets/images/linkedin.svg',
        'url': 'https://www.linkedin.com/in/mohamed-amr-667749222/',
        'description': 'Connect professionally',
      },
    ];

    return Responsive.responsive(
      context,
      mobile: _buildMobileSocialLinks(socialLinks, themeProvider, context),
      desktop: _buildDesktopSocialLinks(socialLinks, themeProvider, context),
    );
  }

  Widget _buildMobileSocialLinks(
    List<Map<String, String>> socialLinks,
    ThemeProvider themeProvider,
    BuildContext context,
  ) {
    return Column(
      children:
          socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return Container(
              margin: EdgeInsets.only(
                bottom: Responsive.getSpacing(context, multiplier: 0.75),
              ),
              child: _buildSocialButton(
                link,
                themeProvider,
                index,
                fullWidth: true,
              ),
            );
          }).toList(),
    );
  }

  Widget _buildDesktopSocialLinks(
    List<Map<String, String>> socialLinks,
    ThemeProvider themeProvider,
    BuildContext context,
  ) {
    return Wrap(
      spacing: Responsive.getSpacing(context, multiplier: 0.75),
      runSpacing: Responsive.getSpacing(context, multiplier: 0.75),
      children:
          socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return _buildSocialButton(link, themeProvider, index);
          }).toList(),
    );
  }

  Widget _buildSocialButton(
    Map<String, String> link,
    ThemeProvider themeProvider,
    int index, {
    bool fullWidth = false,
  }) {
    return _SocialButton(
      link: link,
      themeProvider: themeProvider,
      index: index,
      fullWidth: fullWidth,
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: Responsive.getFontSize(context, mobile: 12, desktop: 16),
          color: AppColors.grey,
          fontFamily: 'SpaceGrotesk',
        ),
        child: AnimatedTextKit(
          isRepeatingAnimation: false,
          repeatForever: false,
          animatedTexts: [
            WavyAnimatedText(
              '© 2025 Mohamed Amr Ibrahim. All rights reserved.',
              speed: const Duration(milliseconds: 80),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1400.ms);
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _SocialButton extends StatefulWidget {
  final Map<String, String> link;
  final ThemeProvider themeProvider;
  final int index;
  final bool fullWidth;

  const _SocialButton({
    required this.link,
    required this.themeProvider,
    required this.index,
    this.fullWidth = false,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(begin: 2.0, end: 8.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    setState(() => _isHovered = hovering);
    if (hovering) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _launchUrl(widget.link['url']!);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isPressed ? 0.95 : _scaleAnimation.value,
                  child: Container(
                    width: widget.fullWidth ? double.infinity : null,
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getSpacing(context, multiplier: 1),
                      vertical: Responsive.getSpacing(
                        context,
                        multiplier: 0.75,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.themeProvider.isDarkMode
                              ? AppColors.buttonColorDark
                              : AppColors.buttonColorLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: (widget.themeProvider.isDarkMode
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight)
                            .withOpacity(_isHovered ? 0.4 : 0.2),
                        width: _isHovered ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (widget.themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColorLight)
                              .withOpacity(0.1),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value * 0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize:
                          widget.fullWidth
                              ? MainAxisSize.max
                              : MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          widget.link['icon']!,
                          width: Responsive.getIconSize(context),
                          height: Responsive.getIconSize(context),
                          colorFilter: ColorFilter.mode(
                            widget.themeProvider.isDarkMode
                                ? AppColors.white
                                : AppColors.darkText,
                            BlendMode.srcIn,
                          ),
                        ),
                        SizedBox(
                          width: Responsive.getSpacing(
                            context,
                            multiplier: 0.5,
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment:
                              widget.fullWidth
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              widget.link['name']!,
                              fontSize: Responsive.getFontSize(
                                context,
                                mobile: 14,
                                desktop: 15,
                              ),
                              fontWeight: FontWeight.w600,
                              color:
                                  widget.themeProvider.isDarkMode
                                      ? AppColors.white
                                      : AppColors.darkText,
                            ),
                            if (widget.fullWidth &&
                                widget.link['description'] != null) ...[
                              SizedBox(height: 2),
                              CustomText(
                                widget.link['description']!,
                                fontSize: Responsive.getFontSize(
                                  context,
                                  mobile: 11,
                                  desktop: 12,
                                ),
                                fontWeight: FontWeight.w400,
                                color: (widget.themeProvider.isDarkMode
                                        ? AppColors.white
                                        : AppColors.darkText)
                                    .withOpacity(0.7),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 1200 + (widget.index * 100)))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3);
  }
}
