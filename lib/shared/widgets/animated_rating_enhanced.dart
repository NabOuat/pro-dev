import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class AnimatedRatingEnhanced extends StatefulWidget {
  final String label;
  final int initialRating;
  final void Function(int)? onRatingChanged;
  final int maxRating;

  const AnimatedRatingEnhanced({
    super.key,
    required this.label,
    this.initialRating = 0,
    this.onRatingChanged,
    this.maxRating = 5,
  });

  @override
  State<AnimatedRatingEnhanced> createState() => _AnimatedRatingEnhancedState();
}

class _AnimatedRatingEnhancedState extends State<AnimatedRatingEnhanced>
    with SingleTickerProviderStateMixin {
  late int _currentRating;
  late AnimationController _animationController;
  late List<Animation<double>> _starAnimations;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.initialRating;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _starAnimations = List.generate(
      widget.maxRating,
      (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.1,
            0.6 + (index * 0.1),
            curve: Curves.elasticOut,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setRating(int rating) {
    setState(() => _currentRating = rating);
    _animationController.forward(from: 0.0);
    widget.onRatingChanged?.call(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: List.generate(
            widget.maxRating,
            (index) => _buildAnimatedStar(index),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedStar(int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _setRating(index + 1),
        child: AnimatedBuilder(
          animation: _starAnimations[index],
          builder: (context, child) {
            final isActive = index < _currentRating;
            return Transform.scale(
              scale: 0.8 + (_starAnimations[index].value * 0.2),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Fond animé
                    if (isActive)
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(
                            0.2 * _starAnimations[index].value,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    // Étoile
                    Icon(
                      isActive ? Icons.star : Icons.star_outline,
                      size: 32.sp,
                      color: isActive
                          ? AppColors.primary
                          : AppColors.textTertiary,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
