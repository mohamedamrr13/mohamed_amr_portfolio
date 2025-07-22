import 'package:flutter/material.dart';
import 'package:my_portfolio/core/shared/background_widget.dart';
import 'package:my_portfolio/core/shared/custom_button.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/core/utils/responsive.dart';
import 'package:my_portfolio/core/utils/scroll_controller.dart';
import 'package:my_portfolio/features/home/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorDark,
      body: const BackgroundWidget(child: HomeScreenBody()),
      appBar: _buildAppBar(context),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AppBar(
      backgroundColor: AppColors.primaryColorDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: isMobile ? null : double.maxFinite,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.developer_mode, color: AppColors.white, size: 28),
          const SizedBox(width: 7),
          CustomText(
            "Mohamed Amr's Portfolio",
            fontSize: Responsive.isTablet(context) || isMobile ? 18 : 22,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),

      actions:
          Responsive.getWidth(context) < 850
              ? [_buildMobileMenu(context)]
              : _buildDesktopActions(),
    );
  }

  Widget _buildMobileMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.menu, color: AppColors.white),
      color: AppColors.buttonColorDark,
      onSelected: (value) => PortfolioScrollController.scrollToSection(value),
      itemBuilder:
          (context) => [
            _buildPopupMenuItem('about', 'About'),
            _buildPopupMenuItem('experience', 'Experience'),
            _buildPopupMenuItem('projects', 'Projects'),
            _buildPopupMenuItem('skills', 'Skills'),
            _buildPopupMenuItem('contact', 'Contact'),
          ],
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: CustomText(text, fontSize: 14, fontWeight: FontWeight.w500),
    );
  }

  List<Widget> _buildDesktopActions() {
    return [
      CustomButton(
        onPressed: () => PortfolioScrollController.scrollToSection('about'),
        shrinkWrap: true,
        backgroundColor: AppColors.buttonColorDark,
        child: const CustomText(
          "About",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      CustomButton(
        onPressed:
            () => PortfolioScrollController.scrollToSection('experience'),
        shrinkWrap: true,
        backgroundColor: AppColors.buttonColorDark,
        child: const CustomText(
          "Experience",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      CustomButton(
        onPressed: () => PortfolioScrollController.scrollToSection('projects'),
        shrinkWrap: true,
        backgroundColor: AppColors.buttonColorDark,
        child: const CustomText(
          "Projects",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      CustomButton(
        onPressed: () => PortfolioScrollController.scrollToSection('skills'),
        shrinkWrap: true,
        backgroundColor: AppColors.buttonColorDark,
        child: const CustomText(
          "Skills",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      CustomButton(
        onPressed: () => PortfolioScrollController.scrollToSection('contact'),
        shrinkWrap: true,
        backgroundColor: AppColors.buttonColorDark,
        child: const CustomText(
          "Contact",
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(width: 16),
    ];
  }
}
