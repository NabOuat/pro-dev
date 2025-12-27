import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/localization/app_strings.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSendReset() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
          _emailSent = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        title: Text(
          'ApprendChap',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF6366F1),
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  _emailSent ? 'Check Your Email' : 'Reset Password',
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  _emailSent
                      ? 'We have sent password reset instructions to your email address.'
                      : 'Enter your email address and we will send you instructions to reset your password.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 40.h),
                if (!_emailSent)
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        ToggleInput(
                          emailHint: AppStrings.enterEmail,
                          phoneHint: AppStrings.enterPhone,
                          emailController: _emailController,
                          phoneController: _phoneController,
                          emailValidator: (value) {
                            if (value?.isEmpty ?? true) {
                              return AppStrings.fieldRequired;
                            }
                            if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                            ).hasMatch(value!)) {
                              return AppStrings.invalidEmail;
                            }
                            return null;
                          },
                          phoneValidator: (value) {
                            if (value?.isEmpty ?? true) {
                              return AppStrings.fieldRequired;
                            }
                            if (value!.length < 10) {
                              return AppStrings.invalidPhone;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),
                        CustomButton(
                          text: AppStrings.sendResetLink,
                          onPressed: _handleSendReset,
                          isLoading: _isLoading,
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Color(0xFF6366F1),
                          size: 50,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      CustomButton(
                        text: 'Back to Login',
                        onPressed: () => context.go('/login'),
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          setState(() => _emailSent = false);
                          _emailController.clear();
                        },
                        child: Text(
                          'Didn\'t receive email? Try another email',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF6366F1),
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
