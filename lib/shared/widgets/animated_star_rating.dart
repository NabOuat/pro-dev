import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/academic_data.dart';

class AnimatedStarRating extends StatefulWidget {
  final String label;
  final ValueChanged<int> onRatingChanged;
  final int initialRating;
  final bool enableHapticFeedback;
  final bool allowClear;

  const AnimatedStarRating({
    super.key,
    required this.label,
    required this.onRatingChanged,
    this.initialRating = 0,
    this.enableHapticFeedback = true,
    this.allowClear = true,
  });

  @override
  State<AnimatedStarRating> createState() => _AnimatedStarRatingState();
}

class _AnimatedStarRatingState extends State<AnimatedStarRating>
    with TickerProviderStateMixin {
  late int _rating;
  late List<AnimationController> _starControllers;
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
    
    // Contrôleur individuel pour chaque étoile
    _starControllers = List.generate(
      5,
      (_) => AnimationController(
        duration: const Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    
    // Animation de glow pour l'effet lumineux
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeOut),
    );
  }

  @override
  void didUpdateWidget(AnimatedStarRating oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      setState(() => _rating = widget.initialRating);
    }
  }

  @override
  void dispose() {
    for (final controller in _starControllers) {
      controller.dispose();
    }
    _glowController.dispose();
    super.dispose();
  }

  void _setRating(int rating) {
    // Permet de désélectionner en tapant sur la même étoile
    final newRating = (widget.allowClear && _rating == rating) ? 0 : rating;
    
    if (widget.enableHapticFeedback) {
      HapticFeedback.lightImpact();
    }
    
    setState(() => _rating = newRating);
    
    // Anime les étoiles en cascade
    if (newRating > 0) {
      for (int i = 0; i < newRating; i++) {
        Future.delayed(Duration(milliseconds: i * 50), () {
          if (mounted) {
            _starControllers[i].forward(from: 0.0);
          }
        });
      }
      _glowController.forward(from: 0.0);
    }
    
    widget.onRatingChanged(newRating);
  }

  @override
  Widget build(BuildContext context) {
    final ratingInfo = _rating > 0 ? RatingData.ratingInfo[_rating] : null;
    final color = ratingInfo != null 
        ? Color(ratingInfo['color'] as int) 
        : Colors.grey[400]!;
    final emoji = ratingInfo?['emoji'] ?? '⭐';
    final label = ratingInfo?['label'] ?? 'Non noté';

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: _rating > 0 
                ? color.withOpacity(0.05 * _glowAnimation.value) 
                : Colors.transparent,
            border: Border.all(
              color: _rating > 0 
                  ? color.withOpacity(0.3 + 0.2 * _glowAnimation.value)
                  : Colors.grey[300]!,
              width: _rating > 0 ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: _rating > 0
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.15 * _glowAnimation.value),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              if (_rating > 0)
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '$_rating/5',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) => _buildStar(index, color)),
                ),
              ),
              SizedBox(width: 16.w),
              _buildRatingInfo(emoji, label, color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStar(int index, Color activeColor) {
    final isActive = _rating >= index + 1;
    
    return GestureDetector(
      onTap: () => _setRating(index + 1),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: AnimatedBuilder(
          animation: _starControllers[index],
          builder: (context, child) {
            final bounceValue = Curves.elasticOut.transform(
              _starControllers[index].value,
            );
            final scale = isActive ? 1.0 + (bounceValue * 0.25) : 1.0;
            
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                child: Icon(
                  isActive ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isActive ? activeColor : Colors.grey[350],
                  size: 32.sp,
                  shadows: isActive
                      ? [
                          Shadow(
                            color: activeColor.withOpacity(0.4),
                            blurRadius: 8,
                          ),
                        ]
                      : null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRatingInfo(String emoji, String label, Color color) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(animation),
            child: child,
          ),
        );
      },
      child: Container(
        key: ValueKey(_rating),
        constraints: BoxConstraints(minWidth: 70.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: TextStyle(fontSize: 36.sp),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: _rating > 0 ? color : Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget helper pour AnimatedBuilder avec child optimization
class AnimatedBuilder extends AnimatedWidget {
  final Widget? child;
  final Widget Function(BuildContext, Widget?) builder;

  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}