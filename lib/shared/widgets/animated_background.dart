import 'package:flutter/material.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class AnimatedBackground extends StatefulWidget {
  final Widget child;
  final bool useGradient;
  final Duration animationDuration;

  const AnimatedBackground({
    super.key,
    required this.child,
    this.useGradient = true,
    this.animationDuration = const Duration(seconds: 6),
  });

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    )..repeat(reverse: true);

    _gradientAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _gradientAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: _getGradientColors(),
              stops: [
                _gradientAnimation.value,
                0.5 + (_gradientAnimation.value * 0.5),
                1.0,
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }

  List<Color> _getGradientColors() {
    return [
      AppColors.primaryLight.withOpacity(0.3),
      AppColors.primary.withOpacity(0.1),
      AppColors.secondaryLight.withOpacity(0.2),
    ];
  }
}
