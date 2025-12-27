import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class SignupParentStepperPage extends StatefulWidget {
  const SignupParentStepperPage({Key? key}) : super(key: key);

  @override
  State<SignupParentStepperPage> createState() =>
      _SignupParentStepperPageState();
}

class _SignupParentStepperPageState extends State<SignupParentStepperPage> {
  int _currentStep = 0;

  // Étape 1 : Informations personnelles
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Étape 2 : Mot de passe
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Étape 3 : Enfants (optionnel pour plus tard)
  late TextEditingController _childrenInfoController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _childrenInfoController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _childrenInfoController.dispose();
    super.dispose();
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
        if (_passwordController.text.isEmpty) {
          _showError('Veuillez entrer un mot de passe');
          return false;
        }
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
      SnackBar(content: Text(message)),
    );
  }

  void _handleSubmit() {
    if (_validateCurrentStep()) {
      setState(() => _isLoading = true);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        context.push('/otp-verification');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Barre de progression
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      3,
                      (index) => Expanded(
                        child: Container(
                          height: 4.h,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? const Color(0xFF8B5CF6)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Étape ${_currentStep + 1} sur 3',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            // Contenu du stepper
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    if (_currentStep == 0) _buildStep1(),
                    if (_currentStep == 1) _buildStep2(),
                    if (_currentStep == 2) _buildStep3(),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
            // Boutons de navigation
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Row(
                children: [
                  if (_currentStep > 0)
                    Expanded(
                      child: CustomButton(
                        text: 'Précédent',
                        onPressed: _handlePrevious,
                        backgroundColor: Colors.grey[200]!,
                        textColor: Colors.black,
                      ),
                    ),
                  if (_currentStep > 0) SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: _currentStep == 2 ? 'Terminer' : 'Suivant',
                      onPressed:
                          _currentStep == 2 ? _handleSubmit : _handleNext,
                      isLoading: _isLoading,
                      backgroundColor: const Color(0xFF8B5CF6),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Vos informations de base',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          hintText: 'Entrez votre nom',
          labelText: 'Nom Complet',
          controller: _fullNameController,
          prefixIcon: const Icon(Icons.person_outline),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: 'Entrez votre email',
          labelText: 'Email',
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: const Icon(Icons.email_outlined),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: 'Entrez votre téléphone',
          labelText: 'Téléphone',
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          prefixIcon: const Icon(Icons.phone_outlined),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sécurité du Compte',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Créez un mot de passe sécurisé',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          hintText: 'Entrez votre mot de passe',
          labelText: 'Mot de passe',
          controller: _passwordController,
          obscureText: _obscurePassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() => _obscurePassword = !_obscurePassword);
            },
            child: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: 'Confirmez votre mot de passe',
          labelText: 'Confirmation',
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() =>
                  _obscureConfirmPassword = !_obscureConfirmPassword);
            },
            child: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enfants (Optionnel)',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Vous pouvez ajouter les enfants plus tard',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.purple[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.purple[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ℹ️ Gestion des Enfants',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.purple[900],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Vous pourrez ajouter et gérer les profils de vos enfants après la création de votre compte. Cela vous permettra de suivre leur progression et de personnaliser leur apprentissage.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.purple[800],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.green[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Résumé de votre inscription',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.green[900],
                ),
              ),
              SizedBox(height: 12.h),
              _buildSummaryLine('Nom', _fullNameController.text),
              _buildSummaryLine('Email', _emailController.text),
              _buildSummaryLine('Téléphone', _phoneController.text),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryLine(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.green[900],
            ),
          ),
        ],
      ),
    );
  }
}
