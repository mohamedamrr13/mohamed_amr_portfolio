import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/core/shared/custom_text.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.flip(
          flipX: true,
          child: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            radius: 100,
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 95,
              child: ClipOval(
                child: Image.asset(
                  "assets/images/myImage.jpg",
                  width: 200, // same as diameter (2 * radius)
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),

        CustomText("Mohamed Amr", fontSize: 22, fontWeight: FontWeight.bold),
        SizedBox(height: 3),

        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 16.0,
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
                speed: Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Bachelor\'s Degree in Computer Science',
                speed: Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Cross Platform Mobile Application Development',
                speed: Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Flutter Developer',
                speed: Duration(milliseconds: 100),
              ),
            ],
          ),
        ),

        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 16.0,
            color: Color(0xff9CABBA),
            fontFamily: 'SpaceGrotesk',
            fontWeight: FontWeight.w500,
          ),
          child: AnimatedTextKit(
            totalRepeatCount: 1,
            repeatForever: false,
            animatedTexts: [
              TypewriterAnimatedText(
                'Based in Alexandria, Egypt',
                speed: Duration(milliseconds: 100),
              ),
            ],
          ),
        ),

        SizedBox(height: 15),

        CustomText(
          "A passionate Flutter developer with a focus on creating optimized and functional mobile applications.\n Experienced in building scalable and maintainable codebases",
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
