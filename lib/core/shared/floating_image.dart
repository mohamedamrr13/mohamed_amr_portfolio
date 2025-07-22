import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FloatingImage extends StatefulWidget {
  final String imagePath;
  final double radius;
  final double? width;
  final double? height;

  const FloatingImage({
    super.key,
    required this.imagePath,
    this.radius = 100,
    this.width,
    this.height,
  });

  @override
  State<FloatingImage> createState() => _FloatingImageState();
}

class _FloatingImageState extends State<FloatingImage>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _hoverController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        _hoverController.forward();
      },
      onExit: (_) {
        _hoverController.reverse();
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([_floatController, _hoverController]),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 10 * _floatController.value),
            child: Transform.scale(
              scale: 1.0 + (0.1 * _hoverController.value),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20 + (10 * _hoverController.value),
                      offset: Offset(0, 10 + (5 * _hoverController.value)),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: widget.radius,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: widget.radius - 5,
                    child: ClipOval(
                      child: Image.asset(
                        widget.imagePath,
                        width: widget.width ?? (widget.radius * 2),
                        height: widget.height ?? (widget.radius * 2),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.5, 0.5));
  }
}
