import 'package:flutter/material.dart';
import 'package:my_portfolio/core/theming/app_colors.dart';
import 'dart:math' as math;

class BackgroundWidget extends StatefulWidget {
  final Widget child;
  final bool enableParticles;
  final int? particleCount;
  final double animationSpeed;

  const BackgroundWidget({
    super.key,
    required this.child,
    this.enableParticles = true,
    this.particleCount,
    this.animationSpeed = 1.0,
  });

  @override
  State<BackgroundWidget> createState() => _BackgroundWidgetState();
}

class _BackgroundWidgetState extends State<BackgroundWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<ParticleData> _particles;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: (20 / widget.animationSpeed).round()),
      vsync: this,
    )..repeat();

    _initializeParticles();
  }

  void _initializeParticles() {
    final particleCount = widget.particleCount ?? _getResponsiveParticleCount();
    _particles = List.generate(
      particleCount,
      (index) => ParticleData(
        initialX: math.Random().nextDouble() * 500,
        initialY: math.Random().nextDouble() * 500,
        speedX: 20 + math.Random().nextDouble() * 40,
        speedY: 10 + math.Random().nextDouble() * 30,
        size: 1.0 + math.Random().nextDouble() * 2.0,
        opacity: 0.2 + math.Random().nextDouble() * 0.3,
        phaseOffset: math.Random().nextDouble() * 2 * math.pi,
      ),
    );
  }

  int _getResponsiveParticleCount() {
    return WidgetsBinding
                .instance
                .platformDispatcher
                .views
                .first
                .physicalSize
                .width >
            1000
        ? 25
        : 15;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: _modernBackgroundGradient),
      child: Stack(
        children: [
          // Enhanced animated background particles
          if (widget.enableParticles)
            RepaintBoundary(
              child: CustomPaint(
                painter: ParticlesPainter(
                  animation: _controller,
                  particles: _particles,
                  primaryColor: AppColors.primaryColor,
                ),
                size: Size.infinite,
              ),
            ),

          // Multi-layered depth gradients
          Container(
            decoration: const BoxDecoration(gradient: _depthGradientLayer1),
          ),

          Container(
            decoration: const BoxDecoration(gradient: _depthGradientLayer2),
          ),

          // Subtle radial highlight
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0.3, -0.7),
                radius: 1.2,
                colors: [
                  AppColors.primaryColor.withOpacity(0.08),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.7],
              ),
            ),
          ),

          // Main content
          widget.child,
        ],
      ),
    );
  }

  // Enhanced gradient definitions
  static const LinearGradient _modernBackgroundGradient = LinearGradient(
    begin: Alignment(-0.8, -1.0),
    end: Alignment(1.2, 1.0),
    colors: [
      Color(0xFF0A0A0F), // Deep space blue
      Color(0xFF1A1A2E), // Rich dark blue
      Color(0xFF16213E), // Midnight blue
      Color(0xFF0F3460), // Ocean depth
      Color(0xFF1A1A2E), // Rich dark blue
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );

  static const LinearGradient _depthGradientLayer1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.transparent,
      Color(0x0D533483), // Subtle purple tint
      Colors.transparent,
    ],
    stops: [0.0, 0.6, 1.0],
  );

  static const LinearGradient _depthGradientLayer2 = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x0A00D4FF), // Subtle cyan glow
      Colors.transparent,
      Color(0x0A7C4DFF), // Subtle purple glow
    ],
    stops: [0.0, 0.5, 1.0],
  );
}

class ParticleData {
  final double initialX;
  final double initialY;
  final double speedX;
  final double speedY;
  final double size;
  final double opacity;
  final double phaseOffset;

  ParticleData({
    required this.initialX,
    required this.initialY,
    required this.speedX,
    required this.speedY,
    required this.size,
    required this.opacity,
    required this.phaseOffset,
  });
}

class ParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final List<ParticleData> particles;
  final Color primaryColor;

  ParticlesPainter({
    required this.animation,
    required this.particles,
    required this.primaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint =
        Paint()
          ..style = PaintingStyle.fill
          ..blendMode = BlendMode.srcOver;

    for (int i = 0; i < particles.length; i++) {
      final particle = particles[i];

      // Calculate position with smooth floating motion
      final progress = animation.value;
      final floatingY =
          math.sin(progress * 2 * math.pi + particle.phaseOffset) * 20;

      final x =
          (particle.initialX + particle.speedX * progress) % (size.width + 50) -
          25;
      final y =
          (particle.initialY + particle.speedY * progress + floatingY) %
              (size.height + 50) -
          25;

      // Dynamic opacity based on position
      final edgeFade = _calculateEdgeFade(x, y, size);
      final finalOpacity = particle.opacity * edgeFade;

      // Set paint color with calculated opacity
      paint.color = primaryColor.withOpacity(finalOpacity);

      // Draw particle with subtle glow effect
      canvas.drawCircle(Offset(x, y), particle.size, paint);

      // Add subtle glow for larger particles
      if (particle.size > 2.0) {
        paint.color = primaryColor.withOpacity(finalOpacity * 0.3);
        canvas.drawCircle(Offset(x, y), particle.size * 2, paint);
      }
    }
  }

  double _calculateEdgeFade(double x, double y, Size size) {
    const fadeDistance = 100.0;

    final leftFade = x < fadeDistance ? x / fadeDistance : 1.0;
    final rightFade =
        x > size.width - fadeDistance ? (size.width - x) / fadeDistance : 1.0;
    final topFade = y < fadeDistance ? y / fadeDistance : 1.0;
    final bottomFade =
        y > size.height - fadeDistance ? (size.height - y) / fadeDistance : 1.0;

    return (leftFade * rightFade * topFade * bottomFade).clamp(0.0, 1.0);
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) {
    return animation != oldDelegate.animation ||
        particles != oldDelegate.particles ||
        primaryColor != oldDelegate.primaryColor;
  }
}

// Optional: Enhanced version with interactive particles
class InteractiveBackgroundWidget extends StatefulWidget {
  final Widget child;
  final bool enableMouseInteraction;

  const InteractiveBackgroundWidget({
    super.key,
    required this.child,
    this.enableMouseInteraction = true,
  });

  @override
  State<InteractiveBackgroundWidget> createState() =>
      _InteractiveBackgroundWidgetState();
}

class _InteractiveBackgroundWidgetState
    extends State<InteractiveBackgroundWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<InteractiveParticle> _particles;
  Offset? _mousePosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _initializeInteractiveParticles();
  }

  void _initializeInteractiveParticles() {
    _particles = List.generate(
      20,
      (index) => InteractiveParticle(
        position: Offset(
          math.Random().nextDouble() * 500,
          math.Random().nextDouble() * 500,
        ),
        velocity: Offset(
          (math.Random().nextDouble() - 0.5) * 2,
          (math.Random().nextDouble() - 0.5) * 2,
        ),
        size: 1.5 + math.Random().nextDouble() * 2.0,
        opacity: 0.3 + math.Random().nextDouble() * 0.4,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: _modernBackgroundGradient),
      child: MouseRegion(
        onHover:
            widget.enableMouseInteraction
                ? (event) {
                  setState(() {
                    _mousePosition = event.localPosition;
                  });
                }
                : null,
        onExit:
            widget.enableMouseInteraction
                ? (event) {
                  setState(() {
                    _mousePosition = null;
                  });
                }
                : null,
        child: Stack(
          children: [
            RepaintBoundary(
              child: CustomPaint(
                painter: InteractiveParticlesPainter(
                  animation: _controller,
                  particles: _particles,
                  primaryColor: const Color(0xFF00D4FF), // Modern cyan
                  mousePosition: _mousePosition,
                ),
                size: Size.infinite,
              ),
            ),

            // Modern depth layers
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0x0F7C4DFF), // Purple accent
                    Colors.transparent,
                    Color(0x0F00D4FF), // Cyan accent
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
              ),
            ),

            widget.child,
          ],
        ),
      ),
    );
  }

  // Modern gradient for interactive version
  static const LinearGradient _modernBackgroundGradient = LinearGradient(
    begin: Alignment(-0.8, -1.0),
    end: Alignment(1.2, 1.0),
    colors: [
      Color(0xFF0A0A0F), // Deep space blue
      Color(0xFF1A1A2E), // Rich dark blue
      Color(0xFF16213E), // Midnight blue
      Color(0xFF0F3460), // Ocean depth
      Color(0xFF1A1A2E), // Rich dark blue
    ],
    stops: [0.0, 0.25, 0.5, 0.75, 1.0],
  );
}

class InteractiveParticle {
  Offset position;
  Offset velocity;
  final double size;
  final double opacity;

  InteractiveParticle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.opacity,
  });
}

class InteractiveParticlesPainter extends CustomPainter {
  final Animation<double> animation;
  final List<InteractiveParticle> particles;
  final Color primaryColor;
  final Offset? mousePosition;

  InteractiveParticlesPainter({
    required this.animation,
    required this.particles,
    required this.primaryColor,
    this.mousePosition,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paint = Paint()..style = PaintingStyle.fill;

    // Update particle positions
    for (final particle in particles) {
      // Mouse interaction
      if (mousePosition != null) {
        final distance = (particle.position - mousePosition!).distance;
        if (distance < 100) {
          final repulsion =
              (particle.position - mousePosition!) / distance * 0.5;
          particle.velocity += repulsion;
        }
      }

      // Update position
      particle.position += particle.velocity;

      // Wrap around screen
      if (particle.position.dx < 0)
        particle.position = Offset(size.width, particle.position.dy);
      if (particle.position.dx > size.width)
        particle.position = Offset(0, particle.position.dy);
      if (particle.position.dy < 0)
        particle.position = Offset(particle.position.dx, size.height);
      if (particle.position.dy > size.height)
        particle.position = Offset(particle.position.dx, 0);

      // Apply friction
      particle.velocity *= 0.995;

      // Draw particle
      paint.color = primaryColor.withOpacity(particle.opacity);
      canvas.drawCircle(particle.position, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
