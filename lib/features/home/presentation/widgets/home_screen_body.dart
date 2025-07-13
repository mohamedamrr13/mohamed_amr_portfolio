import 'package:flutter/material.dart';
import 'package:my_portfolio/features/home/presentation/widgets/info_section.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [SizedBox(height: 20), InfoSection()],
        ),
      ),
    );
  }
}
