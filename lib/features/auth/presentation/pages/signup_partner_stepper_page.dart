import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/constants/academic_data.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class SignupPartnerStepperPage extends StatefulWidget {
  const SignupPartnerStepperPage({Key? key}) : super(key: key);

  @override
  State<SignupPartnerStepperPage> createState() =>
      _SignupPartnerStepperPageState();
}

class _SignupPartnerStepperPageState extends State<SignupPartnerStepperPage> {
  int _currentStep = 0;

  // Étape 1 : Informations entreprise
  late TextEditingController _companyNameController;
  late TextEditingController _contactPersonController;
  String? _selectedBusinessType;

  // Étape 2 : Coordonnées
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Étape 3 : Mot de passe
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Étape 4 : Commission
  late TextEditingController _commissionController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController();
    _contactPersonController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _commissionController = TextEditingController();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _contactPersonController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _commissionController.dispose();
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
        if (_companyNameController.text.isEmpty) {
          _showError('Veuillez entrer le nom de votre entreprise');
          return false;
        }
        if (_contactPersonController.text.isEmpty) {
          _showError('Veuillez entrer le nom de la personne de contact');
          return false;
        }
        if (_selectedBusinessType == null) {
          _showError('Veuillez sélectionner un type d\'activité');
          return false;
        }
        return true;
      case 1:
        if (_emailController.text.isEmpty) {
          _showError('Veuillez entrer votre email');
          return false;
        }
        if (_phoneController.text.isEmpty) {
          _showError('Veuillez entrer votre téléphone');
          return false;
        }
        return true;
      case 2:
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
                      4,
                      (index) => Expanded(
                        child: Container(
                          height: 4.h,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? const Color(0xFFF59E0B)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Étape ${_currentStep + 1} sur 4',
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
                    if (_currentStep == 3) _buildStep4(),
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
                      text: _currentStep == 3 ? 'Terminer' : 'Suivant',
                      onPressed:
                          _currentStep == 3 ? _handleSubmit : _handleNext,
                      isLoading: _isLoading,
                      backgroundColor: const Color(0xFFF59E0B),
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
          'Informations Entreprise',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Détails de votre entreprise',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          hintText: 'Nom de votre entreprise',
          labelText: 'Nom Entreprise',
          controller: _companyNameController,
          prefixIcon: const Icon(Icons.business_outlined),
        ),
        SizedBox(height: 16.h),
        CustomTextField(
          hintText: 'Nom de la personne de contact',
          labelText: 'Personne de Contact',
          controller: _contactPersonController,
          prefixIcon: const Icon(Icons.person_outline),
        ),
        SizedBox(height: 16.h),
        Text(
          'Type d\'Activité',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: _selectedBusinessType,
          hint: const Text('Sélectionnez un type'),
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
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coordonnées',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Vos informations de contact',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
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

  Widget _buildStep3() {
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

  Widget _buildStep4() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Informations Commission',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Détails de votre programme de commission',
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
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💰 Programme de Commission',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.amber[900],
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'En tant que partenaire, vous recevrez une commission sur chaque abonnement vendu via votre lien de parrainage. Les détails de votre programme seront confirmés après validation de votre compte.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.amber[800],
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
              _buildSummaryLine('Entreprise', _companyNameController.text),
              _buildSummaryLine('Contact', _contactPersonController.text),
              _buildSummaryLine('Type', _selectedBusinessType ?? 'Non sélectionné'),
              _buildSummaryLine('Email', _emailController.text),
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
