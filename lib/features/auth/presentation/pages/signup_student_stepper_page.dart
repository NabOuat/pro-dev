import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/constants/academic_data.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class SignupStudentStepperPage extends StatefulWidget {
  const SignupStudentStepperPage({super.key});

  @override
  State<SignupStudentStepperPage> createState() =>
      _SignupStudentStepperPageState();
}

class _SignupStudentStepperPageState extends State<SignupStudentStepperPage> {
  int _currentStep = 0;

  // Étape 1 : Informations personnelles
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // Étape 2 : Classe et Série/Filière
  String? _selectedGrade;
  String? _selectedSerie;
  String? _selectedBtsYear;
  String? _selectedBtsFiliere;

  // Étape 3 : Notation des matières
  final Map<String, int> _subjectRatings = {};

  // Étape 4 : Mot de passe
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Étape 5 : Code de parrainage
  late TextEditingController _referralCodeController;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _referralCodeController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  List<String> _getAvailableSubjects() {
    if (_selectedGrade == 'BTS' && _selectedBtsFiliere != null) {
      return AcademicData.subjectsByBtsFiliere[_selectedBtsFiliere] ?? [];
    } else if (_selectedGrade != null && _selectedGrade != 'BTS') {
      // Pour lycée (2nde, 1ère, Terminale)
      if (AcademicData.seriesByGrade.containsKey(_selectedGrade) && _selectedSerie != null) {
        return AcademicData.subjectsBySerie[_selectedSerie] ?? [];
      }
      // Pour primaire et collège
      return AcademicData.subjectsByGrade[_selectedGrade] ?? [];
    }
    return [];
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
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez entrer votre nom complet')),
          );
          return false;
        }
        if (_emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez entrer votre email')),
          );
          return false;
        }
        if (_phoneController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez entrer votre téléphone')),
          );
          return false;
        }
        return true;
      case 1:
        if (_selectedGrade == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez sélectionner votre classe')),
          );
          return false;
        }
        if (_selectedGrade == 'BTS') {
          if (_selectedBtsYear == null || _selectedBtsFiliere == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Veuillez sélectionner votre année et filière BTS')),
            );
            return false;
          }
        } else if (AcademicData.seriesByGrade.containsKey(_selectedGrade)) {
          if (_selectedSerie == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Veuillez sélectionner votre série')),
            );
            return false;
          }
        }
        return true;
      case 2:
        final subjects = _getAvailableSubjects();
        if (_subjectRatings.length != subjects.length) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez noter toutes les matières')),
          );
          return false;
        }
        return true;
      case 3:
        if (_passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Veuillez entrer un mot de passe')),
          );
          return false;
        }
        if (_passwordController.text.length < 8) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Le mot de passe doit contenir au moins 8 caractères')),
          );
          return false;
        }
        if (_passwordController.text != _confirmPasswordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Les mots de passe ne correspondent pas')),
          );
          return false;
        }
        return true;
      case 4:
        return true;
      default:
        return true;
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
                      5,
                      (index) => Expanded(
                        child: Container(
                          height: 4.h,
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          decoration: BoxDecoration(
                            color: index <= _currentStep
                                ? const Color(0xFF6366F1)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Étape ${_currentStep + 1} sur 5',
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
                    if (_currentStep == 4) _buildStep5(),
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
                      text: _currentStep == 4 ? 'Terminer' : 'Suivant',
                      onPressed:
                          _currentStep == 4 ? _handleSubmit : _handleNext,
                      isLoading: _isLoading,
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
          'Commençons par vos informations de base',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          hintText: 'Entrez votre nom complet',
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
          'Classe et Niveau d\'Études',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Sélectionnez votre classe et vos options',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        Text(
          'Classe',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: _selectedGrade,
          hint: const Text('Sélectionnez votre classe'),
          items: AcademicData.allGrades
              .map((grade) => DropdownMenuItem(
                    value: grade,
                    child: Text(grade),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedGrade = value;
              _selectedSerie = null;
              _selectedBtsYear = null;
              _selectedBtsFiliere = null;
              _subjectRatings.clear();
            });
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          ),
        ),
        SizedBox(height: 24.h),
        // Afficher les options selon la classe sélectionnée
        if (_selectedGrade != null) ...[
          // Pour lycée (2nde, 1ère, Terminale)
          if (AcademicData.seriesByGrade.containsKey(_selectedGrade)) ...[
            Text(
              'Série',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<String>(
              initialValue: _selectedSerie,
              hint: const Text('Sélectionnez votre série'),
              items: (AcademicData.seriesByGrade[_selectedGrade] ?? [])
                  .map((serie) => DropdownMenuItem(
                        value: serie,
                        child: Text(serie),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedSerie = value;
                  _subjectRatings.clear();
                });
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
          // Pour BTS
          if (_selectedGrade == 'BTS') ...[
            SizedBox(height: 16.h),
            Text(
              'Année',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<String>(
              initialValue: _selectedBtsYear,
              hint: const Text('Sélectionnez votre année'),
              items: AcademicData.btsYears
                  .map((year) => DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBtsYear = value;
                  _subjectRatings.clear();
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Filière',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            DropdownButtonFormField<String>(
              initialValue: _selectedBtsFiliere,
              hint: const Text('Sélectionnez votre filière'),
              items: AcademicData.btsFiliere
                  .map((filiere) => DropdownMenuItem(
                        value: filiere,
                        child: Text(filiere),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedBtsFiliere = value;
                  _subjectRatings.clear();
                });
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
        ],
      ],
    );
  }

  Widget _buildStep3() {
    final subjects = _getAvailableSubjects();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Évaluation des Matières',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Notez votre niveau dans chaque matière',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        ...subjects.map((subject) {
          final rating = _subjectRatings[subject] ?? 0;
          return Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: AnimatedStarRating(
              label: subject,
              initialRating: rating,
              onRatingChanged: (newRating) {
                setState(() {
                  _subjectRatings[subject] = newRating;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildStep4() {
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
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Text(
            '✓ Au moins 8 caractères\n✓ Contient majuscules et minuscules\n✓ Contient chiffres et caractères spéciaux',
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.blue[900],
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStep5() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Code de Parrainage',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Avez-vous un code de parrainage ? (Optionnel)',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 24.h),
        CustomTextField(
          hintText: 'Entrez votre code de parrainage',
          labelText: 'Code de Parrainage',
          controller: _referralCodeController,
          prefixIcon: const Icon(Icons.card_giftcard_outlined),
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
              _buildSummaryLine(
                'Classe',
                _selectedGrade == 'BTS'
                    ? 'BTS ${_selectedBtsFiliere ?? 'N/A'} (${_selectedBtsYear ?? 'N/A'})'
                    : '${_selectedGrade ?? 'N/A'}${_selectedSerie != null ? ' - $_selectedSerie' : ''}',
              ),
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
