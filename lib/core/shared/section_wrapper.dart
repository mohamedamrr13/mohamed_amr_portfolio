import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:mohamed_amr_portfolio/core/utils/responsive.dart';

class SectionWrapper extends StatefulWidget {
  final Widget child;
  final String sectionKey;
  final GlobalKey? globalKey;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double visibilityThreshold;
  final Duration animationDuration;
  final Curve animationCurve;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.sectionKey,
    this.globalKey,
    this.padding,
    this.backgroundColor,
    this.visibilityThreshold = 0.1,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeOutCubic,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.animationCurve,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleVisibilityChanged(VisibilityInfo info) {
    // Trigger animation earlier for better user experience
    if (info.visibleFraction > widget.visibilityThreshold && !_isVisible) {
      setState(() => _isVisible = true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('visibility_${widget.sectionKey}'),
      onVisibilityChanged: _handleVisibilityChanged,
      child: Container(
        key: widget.globalKey,
        width: double.infinity,
        color: widget.backgroundColor,
        padding: widget.padding ?? Responsive.getPadding(context),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: widget.child,
              ),
            );
          },
        ),
      ),
    );
  }
}
