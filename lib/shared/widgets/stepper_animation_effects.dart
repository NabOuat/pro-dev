import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class StepperAnimationEffects extends StatefulWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;
  final List<IconData> stepIcons;
  final Duration animationDuration;

  const StepperAnimationEffects({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
    required this.stepIcons,
    this.animationDuration = const Duration(milliseconds: 800),
  }) : assert(stepLabels.length == totalSteps && stepIcons.length == totalSteps);

  @override
  State<StepperAnimationEffects> createState() =>
      _StepperAnimationEffectsState();
}

class _StepperAnimationEffectsState extends State<StepperAnimationEffects>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.totalSteps,
      (_) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.elasticOut),
            ))
        .toList();

    _fadeAnimations = _controllers
        .map((controller) => Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            ))
        .toList();

    _animateCurrentStep();
  }

  void _animateCurrentStep() {
    for (int i = 0; i < widget.totalSteps; i++) {
      if (i <= widget.currentStep) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  void didUpdateWidget(StepperAnimationEffects oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _animateCurrentStep();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barre de progression avec animation
        ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: LinearProgressIndicator(
            value: (widget.currentStep + 1) / widget.totalSteps,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
            minHeight: 4.h,
          ),
        ),
        SizedBox(height: 24.h),
        // Étapes avec animations
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            widget.totalSteps,
            (index) => _buildAnimatedStep(index),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedStep(int index) {
    final isCompleted = index < widget.currentStep;
    final isCurrent = index == widget.currentStep;

    return Expanded(
      child: ScaleTransition(
        scale: _scaleAnimations[index],
        child: FadeTransition(
          opacity: _fadeAnimations[index],
          child: Column(
            children: [
              // Cercle avec animation de pulse
              Stack(
                alignment: Alignment.center,
                children: [
                  // Pulse effect
                  if (isCurrent)
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                      child: AnimatedBuilder(
                        animation: _controllers[index],
                        builder: (context, child) {
                          return Transform.scale(
                            scale: 1.0 + (_controllers[index].value * 0.2),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primary.withOpacity(
                                  0.1 * (1 - _controllers[index].value),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  // Cercle principal
                  Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted || isCurrent
                          ? AppColors.primary
                          : AppColors.surface,
                      border: Border.all(
                        color: isCurrent
                            ? AppColors.primary
                            : isCompleted
                                ? AppColors.primary
                                : AppColors.border,
                        width: isCurrent ? 2 : 1.5,
                      ),
                      boxShadow: isCurrent
                          ? [
                              BoxShadow(
                                color: AppColors.primary.withOpacity(0.4),
                                blurRadius: 12,
                                spreadRadius: 2,
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 24.sp,
                            )
                          : Icon(
                              widget.stepIcons[index],
                              color: isCurrent
                                  ? Colors.white
                                  : AppColors.textSecondary,
                              size: 24.sp,
                            ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              // Label
              Text(
                widget.stepLabels[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                  color: isCurrent
                      ? AppColors.primary
                      : isCompleted
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
