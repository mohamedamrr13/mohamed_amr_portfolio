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
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

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
    return Container(
      constraints: BoxConstraints(
        maxWidth: Responsive.getMaxContentWidth(context),
      ),
      child: Responsive.responsive(
        context,
        mobile: _buildMobileLayout(context),
        tablet: _buildTabletLayout(context),
        desktop: _buildDesktopLayout(context),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Responsive.getVerticalPadding(context) * 2),
        _buildProfileImage(),
        SizedBox(height: Responsive.getSpacing(context, multiplier: 1.5)),
        _buildTextContent(context, centered: true),
      ],
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Responsive.getVerticalPadding(context) * 2.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: _buildTextContent(context)),
            SizedBox(width: Responsive.getSpacing(context, multiplier: 2)),
            Expanded(flex: 2, child: Center(child: _buildProfileImage())),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Responsive.getVerticalPadding(context) * 3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 3, child: _buildTextContent(context)),
            SizedBox(width: Responsive.getSpacing(context, multiplier: 3)),
            Expanded(flex: 2, child: Center(child: _buildProfileImage())),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    return const FloatingImage(
          imagePath: "assets/images/myImage.jpg",
          radius: 120,
          enableFloat: true,
          enableHover: true,
        )
        .animate()
        .fadeIn(duration: 800.ms, delay: 200.ms)
        .scale(begin: const Offset(0.8, 0.8), curve: Curves.easeOutBack);
  }

  Widget _buildTextContent(BuildContext context, {bool centered = false}) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Column(
          crossAxisAlignment:
              centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            _buildNameTitle(context, themeProvider, centered),
            SizedBox(height: Responsive.getSpacing(context, multiplier: 0.5)),
            _buildAnimatedTitle(themeProvider, centered),
            SizedBox(height: Responsive.getSpacing(context, multiplier: 0.75)),
            _buildLocationChip(context, themeProvider, centered),
            SizedBox(height: Responsive.getSpacing(context, multiplier: 1.5)),
            _buildDescription(context, themeProvider, centered),
            SizedBox(height: Responsive.getSpacing(context, multiplier: 2)),
            _buildActionButtons(context, themeProvider, centered),
          ],
        );
      },
    );
  }

  Widget _buildNameTitle(
    BuildContext context,
    ThemeProvider themeProvider,
    bool centered,
  ) {
    return CustomText(
          "Mohamed Amr Ibrahim",
          fontSize: Responsive.getFontSize(context, mobile: 28, desktop: 36),
          fontWeight: FontWeight.bold,
          textAlign: centered ? TextAlign.center : TextAlign.start,
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 400.ms)
        .slideX(begin: centered ? 0 : -0.3);
  }

  Widget _buildAnimatedTitle(ThemeProvider themeProvider, bool centered) {
    return Container(
      alignment: centered ? Alignment.center : Alignment.centerLeft,
      child: DefaultTextStyle(
        style: TextStyle(
          fontSize: 18.0,
          color:
              themeProvider.isDarkMode
                  ? AppColors.primaryColor
                  : AppColors.primaryColorLight,
          fontFamily: 'SpaceGrotesk',
          fontWeight: FontWeight.w600,
        ),
        textAlign: centered ? TextAlign.center : TextAlign.start,
        child: AnimatedTextKit(
          totalRepeatCount: 1,
          repeatForever: false,
          animatedTexts: [
            TypewriterAnimatedText(
              'Flutter Developer',
              speed: const Duration(milliseconds: 80),
            ),
            TypewriterAnimatedText(
              'Mobile App Developer',
              speed: const Duration(milliseconds: 80),
            ),
            TypewriterAnimatedText(
              'Cross-Platform Specialist',
              speed: const Duration(milliseconds: 80),
            ),
            TypewriterAnimatedText(
              'Flutter Developer',
              speed: const Duration(milliseconds: 80),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 800.ms);
  }

  Widget _buildLocationChip(
    BuildContext context,
    ThemeProvider themeProvider,
    bool centered,
  ) {
    return Container(
          alignment: centered ? Alignment.center : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: (themeProvider.isDarkMode
                      ? AppColors.primaryColor
                      : AppColors.primaryColorLight)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color:
                    themeProvider.isDarkMode
                        ? AppColors.primaryColor
                        : AppColors.primaryColorLight,
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight,
                ),
                const SizedBox(width: 6),
                CustomText(
                  'Alexandria, Egypt',
                  fontSize: 14,
                  color:
                      themeProvider.isDarkMode
                          ? AppColors.primaryColor
                          : AppColors.primaryColorLight,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 600.ms, delay: 1000.ms)
        .scale(begin: const Offset(0.8, 0.8));
  }

  Widget _buildDescription(
    BuildContext context,
    ThemeProvider themeProvider,
    bool centered,
  ) {
    return CustomText(
      "Flutter Developer specializing in Dart, Flutter, and Firebase, with experience in building scalable, high-performance mobile and web applications. Strong foundation in modern development practices and cross-platform solutions.",
      fontSize: Responsive.getFontSize(context, mobile: 16, desktop: 18),
      fontWeight: FontWeight.w400,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      color: (themeProvider.isDarkMode ? AppColors.white : AppColors.darkText)
          .withOpacity(0.85),
    ).animate().fadeIn(duration: 600.ms, delay: 1200.ms).slideY(begin: 0.3);
  }

  Widget _buildActionButtons(
    BuildContext context,
    ThemeProvider themeProvider,
    bool centered,
  ) {
    final actionButtons = [
      {
        'title': 'View Projects',
        'icon': Icons.work_outline_rounded,
        'isPrimary': true,
        'onPressed': () => _scrollToSection('projects'),
      },
      {
        'title': 'Contact Me',
        'icon': Icons.mail_outline_rounded,
        'isPrimary': false,
        'onPressed': () => _launchUrl('mailto:mohamed.egypt140@gmail.com'),
      },
    ];

    return Container(
      alignment: centered ? Alignment.center : Alignment.centerLeft,
      child: Wrap(
        spacing: Responsive.getSpacing(context, multiplier: 0.75),
        runSpacing: Responsive.getSpacing(context, multiplier: 0.75),
        children:
            actionButtons.asMap().entries.map((entry) {
              final index = entry.key;
              final button = entry.value;
              return _ThemedActionButton(
                title: button['title'] as String,
                icon: button['icon'] as IconData,
                isPrimary: button['isPrimary'] as bool,
                onPressed: button['onPressed'] as VoidCallback,
                themeProvider: themeProvider,
                index: index,
              );
            }).toList(),
      ),
    ).animate().fadeIn(duration: 600.ms, delay: 1400.ms).slideY(begin: 0.3);
  }

  void _scrollToSection(String section) {
    PortfolioScrollController.scrollToSection(section);
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _ThemedActionButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onPressed;
  final ThemeProvider themeProvider;
  final int index;

  const _ThemedActionButton({
    required this.title,
    required this.icon,
    required this.isPrimary,
    required this.onPressed,
    required this.themeProvider,
    required this.index,
  });

  @override
  State<_ThemedActionButton> createState() => _ThemedActionButtonState();
}

class _ThemedActionButtonState extends State<_ThemedActionButton>
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
    widget.onPressed();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
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
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.getSpacing(
                        context,
                        multiplier: 1.5,
                      ),
                      vertical: Responsive.getSpacing(
                        context,
                        multiplier: 0.875,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color:
                          widget.isPrimary
                              ? (widget.themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColorLight)
                              : (widget.themeProvider.isDarkMode
                                  ? AppColors.buttonColorDark
                                  : AppColors.buttonColorLight),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color:
                            widget.isPrimary
                                ? Colors.transparent
                                : (widget.themeProvider.isDarkMode
                                        ? AppColors.primaryColor
                                        : AppColors.black)
                                    .withOpacity(_isHovered ? 0.4 : 0.2),
                        width: _isHovered ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (widget.themeProvider.isDarkMode
                                  ? AppColors.primaryColor
                                  : AppColors.black)
                              .withOpacity(widget.isPrimary ? 0.3 : 0.1),
                          blurRadius: _elevationAnimation.value,
                          offset: Offset(0, _elevationAnimation.value * 0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.icon,
                          size: 18,
                          color:
                              widget.isPrimary
                                  ? widget.themeProvider.isDarkMode
                                      ? AppColors.black
                                      : AppColors.white
                                  : (widget.themeProvider.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black),
                        ),
                        SizedBox(
                          width: Responsive.getSpacing(
                            context,
                            multiplier: 0.5,
                          ),
                        ),
                        CustomText(
                          widget.title,
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 14,
                            desktop: 15,
                          ),
                          fontWeight: FontWeight.w600,
                          color:
                              widget.isPrimary
                                  ? widget.themeProvider.isDarkMode
                                      ? AppColors.black
                                      : AppColors.white
                                  : (widget.themeProvider.isDarkMode
                                      ? AppColors.white
                                      : AppColors.black),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
        .animate(delay: Duration(milliseconds: 1600 + (widget.index * 100)))
        .fadeIn(duration: 400.ms)
        .slideX(begin: 0.3);
  }
}
