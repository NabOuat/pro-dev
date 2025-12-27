import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'custom_text_field.dart';

class ToggleInput extends StatefulWidget {
  final String emailHint;
  final String phoneHint;
  final TextEditingController? emailController;
  final TextEditingController? phoneController;
  final String? Function(String?)? emailValidator;
  final String? Function(String?)? phoneValidator;
  final void Function(String)? onEmailChanged;
  final void Function(String)? onPhoneChanged;

  const ToggleInput({
    Key? key,
    required this.emailHint,
    required this.phoneHint,
    this.emailController,
    this.phoneController,
    this.emailValidator,
    this.phoneValidator,
    this.onEmailChanged,
    this.onPhoneChanged,
  }) : super(key: key);

  @override
  State<ToggleInput> createState() => _ToggleInputState();
}

class _ToggleInputState extends State<ToggleInput> {
  bool _useEmail = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _useEmail = true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: _useEmail
                          ? const Color(0xFF6366F1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: _useEmail ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _useEmail = false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: !_useEmail
                          ? const Color(0xFF6366F1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Center(
                      child: Text(
                        'Téléphone',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color:
                              !_useEmail ? Colors.white : Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        if (_useEmail)
          CustomTextField(
            hintText: widget.emailHint,
            labelText: 'Email',
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: Color(0xFF6366F1),
            ),
            validator: widget.emailValidator,
            onChanged: widget.onEmailChanged,
          )
        else
          CustomTextField(
            hintText: widget.phoneHint,
            labelText: 'Téléphone',
            controller: widget.phoneController,
            keyboardType: TextInputType.phone,
            prefixIcon: const Icon(
              Icons.phone_outlined,
              color: Color(0xFF6366F1),
            ),
            validator: widget.phoneValidator,
            onChanged: widget.onPhoneChanged,
          ),
      ],
    );
  }
}
