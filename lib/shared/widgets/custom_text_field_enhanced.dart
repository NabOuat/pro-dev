import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apprendchap/core/constants/app_colors.dart';

class CustomTextFieldEnhanced extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;
  final int minLines;
  final bool enableRealTimeValidation;

  const CustomTextFieldEnhanced({
    super.key,
    required this.hintText,
    this.labelText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines = 1,
    this.enableRealTimeValidation = true,
  });

  @override
  State<CustomTextFieldEnhanced> createState() =>
      _CustomTextFieldEnhancedState();
}

class _CustomTextFieldEnhancedState extends State<CustomTextFieldEnhanced>
    with SingleTickerProviderStateMixin {
  late bool _obscureText;
  late FocusNode _focusNode;
  String? _errorMessage;
  bool _isValid = true;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    widget.controller?.addListener(_validateInRealTime);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _animationController.dispose();
    widget.controller?.removeListener(_validateInRealTime);
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus) {
      _animationController.forward();
    } else {
      if ((widget.controller?.text ?? '').isEmpty) {
        _animationController.reverse();
      }
    }
  }

  void _validateInRealTime() {
    if (!widget.enableRealTimeValidation) return;

    final value = widget.controller?.text ?? '';
    if (value.isEmpty) {
      setState(() {
        _errorMessage = null;
        _isValid = true;
      });
      return;
    }

    if (widget.validator != null) {
      final error = widget.validator!(value);
      setState(() {
        _errorMessage = error;
        _isValid = error == null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: _focusNode.hasFocus
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: _obscureText,
            focusNode: _focusNode,
            onChanged: (value) {
              widget.onChanged?.call(value);
              if (widget.controller?.text.isNotEmpty ?? false) {
                _animationController.forward();
              }
            },
            maxLines: _obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              prefixIcon: widget.prefixIcon,
              suffixIcon: _buildSuffixIcon(),
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textTertiary,
              ),
              labelStyle: TextStyle(
                fontSize: 14.sp,
                color: _focusNode.hasFocus
                    ? AppColors.primary
                    : AppColors.textSecondary,
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
              fillColor: _focusNode.hasFocus
                  ? AppColors.primaryLight.withOpacity(0.3)
                  : AppColors.surface,
              errorText: _errorMessage,
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
          ),
        ),
        if (_isValid && (widget.controller?.text ?? '').isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 16.sp,
                  color: AppColors.success,
                ),
                SizedBox(width: 6.w),
                Text(
                  'Valide',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.success,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.obscureText) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: _focusNode.hasFocus ? AppColors.primary : AppColors.textSecondary,
          size: 20.sp,
        ),
      );
    }

    if (_errorMessage != null && _errorMessage!.isNotEmpty) {
      return Icon(
        Icons.error_outline,
        color: AppColors.error,
        size: 20.sp,
      );
    }

    return widget.suffixIcon;
  }
}
