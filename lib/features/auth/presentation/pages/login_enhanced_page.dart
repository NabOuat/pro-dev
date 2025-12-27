import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/localization/app_strings.dart';
import 'package:apprendchap/core/constants/app_colors.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class LoginEnhancedPage extends StatefulWidget {
  const LoginEnhancedPage({super.key});

  @override
  State<LoginEnhancedPage> createState() => _LoginEnhancedPageState();
}

class _LoginEnhancedPageState extends State<LoginEnhancedPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _passwordController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      
      try {
        // Simule un délai d'authentification
        await Future.delayed(const Duration(seconds: 2));
        
        if (mounted) {
          setState(() => _isLoading = false);
          context.go('/home'); // Utilise go() au lieu de push() pour remplacer la stack
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erreur de connexion: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionWrapper(
        transitionType: PageTransitionType.fadeSlide,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                SvgPicture.asset(
                  'assets/icons/login.svg',
                  height: 250.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.welcomeBack,
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        AppStrings.signInDescription,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 32.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            AnimatedToggleInput(
                              emailHint: AppStrings.enterEmail,
                              phoneHint: AppStrings.enterPhone,
                              emailLabel: 'Email',
                              phoneLabel: 'Téléphone',
                              emailController: _emailController,
                              phoneController: _phoneController,
                              emailValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.fieldRequired;
                                }
                                if (!RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                ).hasMatch(value)) {
                                  return AppStrings.invalidEmail;
                                }
                                return null;
                              },
                              phoneValidator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.fieldRequired;
                                }
                                if (value.length < 10) {
                                  return AppStrings.invalidPhone;
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomTextFieldEnhanced(
                              hintText: AppStrings.enterPassword,
                              labelText: AppStrings.password,
                              controller: _passwordController,
                              obscureText: true,
                              prefixIcon: const Icon(Icons.lock_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.fieldRequired;
                                }
                                if (value.length < 6) {
                                  return 'Le mot de passe doit contenir au moins 6 caractères';
                                }
                                return null;
                              },
                              enableRealTimeValidation: true,
                            ),
                            SizedBox(height: 12.h),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => context.push('/forgot-password'),
                                child: Text(
                                  AppStrings.forgotPassword,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 32.h),
                            CustomButtonEnhanced(
                              text: 'Se Connecter',
                              onPressed: _isLoading ? () {} : () { _handleLogin(); },
                              isLoading: _isLoading,
                              useGradient: true,
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.border,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  child: Text(
                                    'Ou continuer avec',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: AppColors.border,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: SocialButton(
                                    iconPath: 'assets/icons/google-plus.svg',
                                    label: 'Google',
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: SocialButton(
                                    iconPath: 'assets/icons/facebook.svg',
                                    label: 'Facebook',
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Pas encore de compte ? ",
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => context.push('/signup'),
                                  child: Text(
                                    "S'inscrire",
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
