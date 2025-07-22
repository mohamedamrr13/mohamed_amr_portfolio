import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/presentation/home_screen.dart';

void main() {
  runApp(const MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mohamed Amr - Flutter Developer',
      home: const HomeScreen(),
      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

