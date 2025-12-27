import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/constants/academic_data.dart';
import 'package:apprendchap/core/constants/app_colors.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class SignupPartnerStepperEnhancedPage extends StatefulWidget {
  const SignupPartnerStepperEnhancedPage({super.key});

  @override
  State<SignupPartnerStepperEnhancedPage> createState() =>
      _SignupPartnerStepperEnhancedPageState();
}

class _SignupPartnerStepperEnhancedPageState
    extends State<SignupPartnerStepperEnhancedPage> {
  int _currentStep = 0;

  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _companyNameController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late TextEditingController _descriptionController;

  String? _selectedBusinessType;
  bool _isLoading = false;

  final List<String> _stepLabels = ['Infos', 'Entreprise', 'Sécurité'];
  final List<IconData> _stepIcons = [
    Icons.person_outline,
    Icons.business_outlined,
    Icons.lock_outline,
  ];

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _companyNameController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _companyNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  bool _validateCurrentStep() {
    switch (_currentStep) {
      case 0:
        if (_fullNameController.text.isEmpty) {
          _showError('Veuillez entrer votre nom');
          return false;
        }
        if (_emailController.text.isEmpty) {
          _showError('Veuillez entrer votre email');
          return false;
        }
        if (_phoneController.text.isEmpty) {
          _showError('Veuillez entrer votre téléphone');
          return false;
        }
        return true;
      case 1:
        if (_companyNameController.text.isEmpty) {
          _showError('Veuillez entrer le nom de votre entreprise');
          return false;
        }
        if (_selectedBusinessType == null) {
          _showError('Veuillez sélectionner un type d\'activité');
          return false;
        }
        return true;
      case 2:
        if (_passwordController.text.length < 8) {
          _showError('Le mot de passe doit contenir au moins 8 caractères');
          return false;
        }
        if (_passwordController.text != _confirmPasswordController.text) {
          _showError('Les mots de passe ne correspondent pas');
          return false;
        }
        return true;
      default:
        return true;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: Colors.white),
            SizedBox(width: 12.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  void _handleNext() {
    if (_validateCurrentStep()) {
      setState(() => _currentStep++);
    }
  }

  void _handlePrevious() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _handleSubmit() {
    if (_validateCurrentStep()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          context.push('/otp-verification');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionWrapper(
        transitionType: PageTransitionType.fadeSlide,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(24.w),
                child: StepperProgressBar(
                  currentStep: _currentStep,
                  totalSteps: 3,
                  stepLabels: _stepLabels,
                  stepIcons: _stepIcons,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      if (_currentStep == 0) _buildStep1(),
                      if (_currentStep == 1) _buildStep2(),
                      if (_currentStep == 2) _buildStep3(),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        child: CustomButtonEnhanced(
                          text: 'Précédent',
                          onPressed: _handlePrevious,
                          useGradient: false,
                          backgroundColor: AppColors.surface,
                          textColor: AppColors.primary,
                        ),
                      ),
                    if (_currentStep > 0) SizedBox(width: 16.w),
                    Expanded(
                      child: CustomButtonEnhanced(
                        text: _currentStep == 2 ? 'Terminer' : 'Suivant',
                        onPressed:
                            _currentStep == 2 ? _handleSubmit : _handleNext,
                        isLoading: _isLoading,
                        useGradient: true,
                        useSecondaryGradient: _currentStep == 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations Personnelles',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Commençons par vos informations de base',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextFieldEnhanced(
          hintText: 'Entrez votre nom complet',
          labelText: 'Nom Complet',
          controller: _fullNameController,
          prefixIcon: const Icon(Icons.person_outline),
          enableRealTimeValidation: true,
        ),
        SizedBox(height: 16.h),
        CustomTextFieldEnhanced(
          hintText: 'Entrez votre email',
          labelText: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
          enableRealTimeValidation: true,
        ),
        SizedBox(height: 16.h),
        CustomTextFieldEnhanced(
          hintText: 'Entrez votre téléphone',
          labelText: 'Téléphone',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined),
          enableRealTimeValidation: true,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations Entreprise',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Parlez-nous de votre entreprise',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextFieldEnhanced(
          hintText: 'Entrez le nom de votre entreprise',
          labelText: 'Nom de l\'Entreprise',
          controller: _companyNameController,
          prefixIcon: const Icon(Icons.business_outlined),
          enableRealTimeValidation: true,
        ),
        SizedBox(height: 16.h),
        Text(
          'Type d\'Activité',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: _selectedBusinessType,
          hint: const Text('Sélectionnez un type d\'activité'),
          items: AcademicData.businessTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() => _selectedBusinessType = value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            filled: true,
            fillColor: AppColors.surface,
          ),
        ),
        SizedBox(height: 16.h),
        CustomTextFieldEnhanced(
          hintText: 'Décrivez votre entreprise et vos services',
          labelText: 'Description',
          controller: _descriptionController,
          prefixIcon: const Icon(Icons.description_outlined),
          maxLines: 4,
          minLines: 3,
          enableRealTimeValidation: false,
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sécurité du Compte',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Créez un mot de passe sécurisé',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextFieldEnhanced(
          hintText: 'Entrez votre mot de passe',
          labelText: 'Mot de passe',
          controller: _passwordController,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
          enableRealTimeValidation: true,
        ),
        SizedBox(height: 16.h),
        CustomTextFieldEnhanced(
          hintText: 'Confirmez votre mot de passe',
          labelText: 'Confirmer le mot de passe',
          controller: _confirmPasswordController,
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline),
          enableRealTimeValidation: true,
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.info.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.info.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.security_outlined,
                color: AppColors.info,
                size: 20.sp,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Utilisez un mot de passe fort avec au moins 8 caractères, incluant majuscules, minuscules et chiffres.',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
