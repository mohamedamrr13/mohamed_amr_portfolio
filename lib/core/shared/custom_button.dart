import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.child,
    this.onPressed,
    this.margin,
    required this.backgroundColor,
    this.disabledButtonColor,
    this.borderRadius = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.shrinkWrap = false,
    this.width,
    this.height,
    this.hoverScale = 1.1, // Scale factor on hover
    this.animationDuration = const Duration(milliseconds: 200),
  });

  final Widget? child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? margin;
  final Color backgroundColor;
  final Color? disabledButtonColor;
  final double borderRadius;
  final EdgeInsets padding;
  final bool shrinkWrap;
  final double? width;
  final double? height;
  final double hoverScale; // New parameter for hover scale
  final Duration animationDuration; // New parameter for animation duration

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedScale(
          scale: _isHovered ? widget.hoverScale : 1.0,
          duration: widget.animationDuration,
          curve: Curves.easeInOut,
          child: ElevatedButton(
            onPressed: widget.onPressed,
            style: ElevatedButton.styleFrom(
              overlayColor: Colors.blueGrey,
              backgroundColor: widget.backgroundColor,
              disabledBackgroundColor:
                  widget.disabledButtonColor ??
                  widget.backgroundColor.withOpacity(0.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              padding: widget.padding,
              minimumSize:
                  widget.shrinkWrap
                      ? null
                      : Size(widget.width ?? 150, widget.height ?? 50),
              maximumSize:
                  widget.shrinkWrap
                      ? null
                      : Size(widget.width ?? 200, double.infinity),
              alignment: Alignment.center,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
