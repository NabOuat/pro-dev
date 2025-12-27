import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class StepperProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<String> stepLabels;
  final List<IconData> stepIcons;

  const StepperProgressBar({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.stepLabels,
    required this.stepIcons,
  }) : assert(stepLabels.length == totalSteps && stepIcons.length == totalSteps);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Barre de progression linéaire
        ClipRRect(
          borderRadius: BorderRadius.circular(2.r),
          child: LinearProgressIndicator(
            value: (currentStep + 1) / totalSteps,
            backgroundColor: AppColors.divider,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppColors.primary,
            ),
            minHeight: 4.h,
          ),
        ),
        SizedBox(height: 24.h),
        // Étapes numérotées
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            totalSteps,
            (index) => _buildStepItem(index),
          ),
        ),
      ],
    );
  }

  Widget _buildStepItem(int index) {
    final isCompleted = index < currentStep;
    final isCurrent = index == currentStep;

    return Expanded(
      child: Column(
        children: [
          // Cercle avec numéro/icône
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
                        color: AppColors.primary.withOpacity(0.3),
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
                      stepIcons[index],
                      color: isCurrent
                          ? Colors.white
                          : AppColors.textSecondary,
                      size: 24.sp,
                    ),
            ),
          ),
          SizedBox(height: 8.h),
          // Label de l'étape
          Text(
            stepLabels[index],
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
    );
  }
}
