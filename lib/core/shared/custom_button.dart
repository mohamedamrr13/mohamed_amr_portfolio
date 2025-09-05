import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    this.child,
    this.onPressed,
    this.buttonPadding,
    required this.backgroundColor,
    this.disabledButtonColor,
    this.borderRadius = 12,
    this.textPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.shrinkWrap = false,
    this.width,
    this.height,
    this.hoverScale = 1.05, // Reduced for more subtle effect
    this.animationDuration = const Duration(milliseconds: 200),
    this.enableRipple = true,
    this.borderColor,
    this.shadowColor,
    this.elevation = 2,
    this.hoverElevation = 8,
  });

  final Widget? child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? buttonPadding;
  final Color backgroundColor;
  final Color? disabledButtonColor;
  final double borderRadius;
  final EdgeInsets textPadding;
  final bool shrinkWrap;
  final double? width;
  final double? height;
  final double hoverScale;
  final Duration animationDuration;
  final bool enableRipple;
  final Color? borderColor;
  final Color? shadowColor;
  final double elevation;
  final double hoverElevation;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  bool _isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: widget.hoverScale).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleHover(bool hovering) {
    if (_isHovered != hovering) {
      setState(() => _isHovered = hovering);
      if (hovering) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: widget.animationDuration,
      padding:
          widget.buttonPadding ??
          EdgeInsets.symmetric(horizontal: _isHovered ? 6 : 4),
      child: MouseRegion(
        onEnter: (_) => _handleHover(true),
        onExit: (_) => _handleHover(false),
        child: GestureDetector(
          onTapDown: _handleTapDown,
          onTapUp: _handleTapUp,
          onTapCancel: _handleTapCancel,
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _isPressed ? 0.98 : _scaleAnimation.value,
                child: AnimatedContainer(
                  duration: widget.animationDuration,
                  width: widget.width,
                  height: widget.height,
                  decoration: BoxDecoration(
                    color:
                        widget.onPressed == null
                            ? (widget.disabledButtonColor ??
                                widget.backgroundColor.withOpacity(0.5))
                            : widget.backgroundColor,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    border:
                        widget.borderColor != null
                            ? Border.all(color: widget.borderColor!, width: 1)
                            : null,
                    boxShadow: [
                      BoxShadow(
                        color:
                            widget.shadowColor ??
                            widget.backgroundColor.withOpacity(0.3),
                        blurRadius: _elevationAnimation.value,
                        offset: Offset(0, _elevationAnimation.value * 0.3),
                        spreadRadius: _isHovered ? 1 : 0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: widget.onPressed,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      splashColor:
                          widget.enableRipple
                              ? Colors.white.withOpacity(0.2)
                              : Colors.transparent,
                      highlightColor:
                          widget.enableRipple
                              ? Colors.white.withOpacity(0.1)
                              : Colors.transparent,
                      child: Container(
                        padding: widget.textPadding,
                        alignment: Alignment.center,
                        constraints:
                            widget.shrinkWrap
                                ? null
                                : BoxConstraints(
                                  minWidth: widget.width ?? 150,
                                  minHeight: widget.height ?? 50,
                                ),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
