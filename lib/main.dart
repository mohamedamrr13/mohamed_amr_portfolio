import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/presentation/home_screen.dart';

void main() {
  runApp(MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      theme: ThemeData(fontFamily: 'SpaceGrotesk'),
    );
  }
}
