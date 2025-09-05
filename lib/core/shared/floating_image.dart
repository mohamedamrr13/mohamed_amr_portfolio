import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class FloatingImage extends StatefulWidget {
  final String imagePath;
  final double radius;
  final double? width;
  final double? height;
  final bool enableFloat;
  final bool enableHover;

  const FloatingImage({
    super.key,
    required this.imagePath,
    this.radius = 100,
    this.width,
    this.height,
    this.enableFloat = true,
    this.enableHover = true,
  });

  @override
  State<FloatingImage> createState() => _FloatingImageState();
}

class _FloatingImageState extends State<FloatingImage>
    with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _hoverController;
  late Animation<double> _floatAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shadowAnimation;

  @override
  void initState() {
    super.initState();

    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _floatAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    _shadowAnimation = Tween<double>(begin: 15.0, end: 25.0).animate(
      CurvedAnimation(parent: _hoverController, curve: Curves.easeOutCubic),
    );

    if (widget.enableFloat) {
      _floatController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _floatController.dispose();
    _hoverController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    if (widget.enableHover) {
      if (hovering) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
          onEnter: (_) => _handleHover(true),
          onExit: (_) => _handleHover(false),
          child: AnimatedBuilder(
            animation: Listenable.merge([_floatController, _hoverController]),
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  widget.enableFloat ? _floatAnimation.value : 0,
                ),
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: _shadowAnimation.value,
                          offset: Offset(0, _shadowAnimation.value * 0.4),
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: _shadowAnimation.value * 0.5,
                          offset: Offset(0, _shadowAnimation.value * 0.2),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade300,
                      radius: widget.radius,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: widget.radius - 4,
                        child: ClipOval(
                          child: Image.asset(
                            widget.imagePath,
                            width: widget.width ?? (widget.radius * 2),
                            height: widget.height ?? (widget.radius * 2),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: widget.width ?? (widget.radius * 2),
                                height: widget.height ?? (widget.radius * 2),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.person,
                                  size: widget.radius,
                                  color: Colors.grey.shade600,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
        .animate()
        .fadeIn(duration: 800.ms)
        .scale(
          begin: const Offset(0.8, 0.8),
          duration: 600.ms,
          curve: Curves.easeOutBack,
        );
  }
}
