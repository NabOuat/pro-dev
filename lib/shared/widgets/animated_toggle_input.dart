import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class AnimatedToggleInput extends StatefulWidget {
  final String emailHint;
  final String phoneHint;
  final String? emailLabel;
  final String? phoneLabel;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? phoneValidator;
  final void Function(String)? onEmailChanged;
  final void Function(String)? onPhoneChanged;
  final void Function(bool)? onToggle;

  const AnimatedToggleInput({
    super.key,
    required this.emailHint,
    required this.phoneHint,
    this.emailLabel,
    this.phoneLabel,
    required this.emailController,
    required this.phoneController,
    this.emailValidator,
    this.phoneValidator,
    this.onEmailChanged,
    this.onPhoneChanged,
    this.onToggle,
  });

  @override
  State<AnimatedToggleInput> createState() => _AnimatedToggleInputState();
}

class _AnimatedToggleInputState extends State<AnimatedToggleInput>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _slideAnimation;
  bool _useEmail = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCubic),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleInput() {
    if (_useEmail) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() => _useEmail = !_useEmail);
    widget.onToggle?.call(_useEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle Button avec animation
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: _useEmail ? null : _toggleInput,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      color: _useEmail ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 18.sp,
                            color: _useEmail
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: _useEmail
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: GestureDetector(
                  onTap: !_useEmail ? null : _toggleInput,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      color: !_useEmail ? AppColors.primary : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.phone_outlined,
                            size: 18.sp,
                            color: !_useEmail
                                ? Colors.white
                                : AppColors.textSecondary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Téléphone',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: !_useEmail
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Champ Email ou Téléphone avec animation
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_slideAnimation.value * 20, 0),
              child: Opacity(
                opacity: 1.0 - (_slideAnimation.value * 0.3),
                child: _useEmail
                    ? _buildEmailField()
                    : _buildPhoneField(),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: widget.emailController,
      keyboardType: TextInputType.emailAddress,
      onChanged: widget.onEmailChanged,
      validator: widget.emailValidator,
      decoration: InputDecoration(
        hintText: widget.emailHint,
        labelText: widget.emailLabel ?? 'Email',
        prefixIcon: const Icon(Icons.email_outlined),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textTertiary,
        ),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildPhoneField() {
    return TextFormField(
      controller: widget.phoneController,
      keyboardType: TextInputType.phone,
      onChanged: widget.onPhoneChanged,
      validator: widget.phoneValidator,
      decoration: InputDecoration(
        hintText: widget.phoneHint,
        labelText: widget.phoneLabel ?? 'Téléphone',
        prefixIcon: const Icon(Icons.phone_outlined),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textTertiary,
        ),
        labelStyle: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.border,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: AppColors.surface,
        errorStyle: TextStyle(
          fontSize: 12.sp,
          color: AppColors.error,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: TextStyle(
        fontSize: 14.sp,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
