import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:my_portfolio/core/utils/responsive.dart';

class SectionWrapper extends StatefulWidget {
  final Widget child;
  final String sectionKey;
  final GlobalKey? globalKey;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.sectionKey,
    this.globalKey,
    this.padding,
    this.backgroundColor,
  });

  @override
  State<SectionWrapper> createState() => _SectionWrapperState();
}

class _SectionWrapperState extends State<SectionWrapper> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.sectionKey),
      onVisibilityChanged: (info) {
        // Trigger animation much earlier - when just 5% is visible
        if (info.visibleFraction > 0.05 && !_isVisible) {
          setState(() => _isVisible = true);
        }
      },
      child: Container(
        key: widget.globalKey,
        width: double.infinity,
        color: widget.backgroundColor,
        padding: widget.padding ?? Responsive.getPadding(context),
        child:
            _isVisible
                ? widget.child.animate().fadeIn(
                  duration: 200.ms, // Reduced from 300ms
                  curve: Curves.easeOut, // Simpler curve
                )
                : Opacity(opacity: 0, child: widget.child),
      ),
    );
  }
}
