import 'package:flutter/material.dart';

class PageTransitionWrapper extends StatelessWidget {
  final Widget child;
  final PageTransitionType transitionType;
  final Duration duration;

  const PageTransitionWrapper({
    super.key,
    required this.child,
    this.transitionType = PageTransitionType.fadeSlide,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  Widget build(BuildContext context) {
    return switch (transitionType) {
      PageTransitionType.fade => _FadeTransition(
          duration: duration,
          child: child,
        ),
      PageTransitionType.slide => _SlideTransition(
          duration: duration,
          child: child,
        ),
      PageTransitionType.fadeSlide => _FadeSlideTransition(
          duration: duration,
          child: child,
        ),
      PageTransitionType.scale => _ScaleTransition(
          duration: duration,
          child: child,
        ),
    };
  }
}

enum PageTransitionType {
  fade,
  slide,
  fadeSlide,
  scale,
}

class _FadeTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _FadeTransition({
    required this.child,
    required this.duration,
  });

  @override
  State<_FadeTransition> createState() => _FadeTransitionState();
}

class _FadeTransitionState extends State<_FadeTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
  }
}

class _SlideTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _SlideTransition({
    required this.child,
    required this.duration,
  });

  @override
  State<_SlideTransition> createState() => _SlideTransitionState();
}

class _SlideTransitionState extends State<_SlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: widget.child,
    );
  }
}

class _FadeSlideTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _FadeSlideTransition({
    required this.child,
    required this.duration,
  });

  @override
  State<_FadeSlideTransition> createState() => _FadeSlideTransitionState();
}

class _FadeSlideTransitionState extends State<_FadeSlideTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}

class _ScaleTransition extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const _ScaleTransition({
    required this.child,
    required this.duration,
  });

  @override
  State<_ScaleTransition> createState() => _ScaleTransitionState();
}

class _ScaleTransitionState extends State<_ScaleTransition>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
