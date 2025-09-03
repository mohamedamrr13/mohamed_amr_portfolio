import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theming/theme_provider.dart';
import '../theming/app_colors.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({super.key});

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.elasticOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _toggleTheme() async {
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    _rotationController.forward().then((_) {
      _rotationController.reset();
    });

    await Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedBuilder(
          animation: Listenable.merge([_rotationAnimation, _scaleAnimation]),
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Transform.rotate(
                angle:
                    _rotationAnimation.value * 6.28, // 2 * pi for full rotation
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (themeProvider.isDarkMode
                                ? AppColors.primaryColor
                                : AppColors.primaryColorLight)
                            .withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _toggleTheme,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              themeProvider.isDarkMode
                                  ? AppColors.buttonColorDark
                                  : AppColors.buttonColorLight,
                          border: Border.all(
                            color:
                                themeProvider.isDarkMode
                                    ? AppColors.primaryColor.withOpacity(0.3)
                                    : AppColors.primaryColorLight.withOpacity(
                                      0.3,
                                    ),
                            width: 2,
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: Center(
                            child: Icon(
                              themeProvider.isDarkMode
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              key: ValueKey(themeProvider.isDarkMode),
                              color:
                                  themeProvider.isDarkMode
                                      ? AppColors.primaryColor
                                      : AppColors.primaryColorLight,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
