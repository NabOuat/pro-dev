import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/localization/app_strings.dart';
import 'package:apprendchap/core/constants/app_colors.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class ForgotPasswordEnhancedPage extends StatefulWidget {
  const ForgotPasswordEnhancedPage({super.key});

  @override
  State<ForgotPasswordEnhancedPage> createState() =>
      _ForgotPasswordEnhancedPageState();
}

class _ForgotPasswordEnhancedPageState extends State<ForgotPasswordEnhancedPage> {
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
        if (mounted) {
          setState(() {
            _isLoading = false;
            _emailSent = true;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.background,
        leading: GestureDetector(
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20.sp,
          ),
        ),
        title: Text(
          'ApprendChap',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
      ),
      body: PageTransitionWrapper(
        transitionType: PageTransitionType.fadeSlide,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Text(
                    _emailSent
                        ? 'Vérifiez votre email'
                        : 'Réinitialiser le mot de passe',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _emailSent
                        ? 'Nous avons envoyé les instructions de réinitialisation du mot de passe à votre adresse email.'
                        : 'Entrez votre adresse email ou numéro de téléphone et nous vous enverrons les instructions pour réinitialiser votre mot de passe.',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  if (!_emailSent)
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Toggle Email/Phone avec animation
                          AnimatedToggleInput(
                            emailHint: AppStrings.enterEmail,
                            phoneHint: AppStrings.enterPhone,
                            emailLabel: 'Email',
                            phoneLabel: 'Téléphone',
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
                          CustomButtonEnhanced(
                            text: AppStrings.sendResetLink,
                            onPressed: _handleSendReset,
                            isLoading: _isLoading,
                            useGradient: true,
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
                            color: AppColors.success.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            color: AppColors.success,
                            size: 50.sp,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        CustomButtonEnhanced(
                          text: 'Retour à la connexion',
                          onPressed: () => context.go('/login'),
                          useGradient: true,
                        ),
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            setState(() => _emailSent = false);
                            _emailController.clear();
                            _phoneController.clear();
                          },
                          child: Text(
                            'Vous n\'avez pas reçu l\'email ? Essayez une autre adresse',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
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
      ),
    );
  }
}
