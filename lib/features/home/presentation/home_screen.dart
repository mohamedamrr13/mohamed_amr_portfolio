import 'package:flutter/material.dart';
import 'package:my_portfolio/core/shared/custom_button.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'package:my_portfolio/features/home/presentation/widgets/home_screen_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColorDark,
      body: HomeScreenBody(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorDark,
        leadingWidth: double.maxFinite,
        title: CustomText(
          "Mohamed Amr",
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: Divider(thickness: 0.3),
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16),

        actions: [
          CustomButton(
            onPressed: () {},

            margin: EdgeInsets.only(right: 8),
            shrinkWrap: true,
            backgroundColor: AppColors.buttonColorDark,
            child: CustomText(
              "About",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomButton(
            onPressed: () {},
            margin: EdgeInsets.only(right: 8),
            shrinkWrap: true,
            backgroundColor: AppColors.buttonColorDark,
            child: CustomText(
              "Experience",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomButton(
            onPressed: () {},

            margin: EdgeInsets.only(right: 8),
            shrinkWrap: true,
            backgroundColor: AppColors.buttonColorDark,
            child: CustomText(
              "Projects",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomButton(
            onPressed: () {},

            margin: EdgeInsets.only(right: 8),
            shrinkWrap: true,
            backgroundColor: AppColors.buttonColorDark,
            child: CustomText(
              "Skills",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          CustomButton(
            onPressed: () {},

            margin: EdgeInsets.only(right: 8),
            shrinkWrap: true,
            backgroundColor: AppColors.buttonColorDark,
            child: CustomText(
              "Contact",
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
