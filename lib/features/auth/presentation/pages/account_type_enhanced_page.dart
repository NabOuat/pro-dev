import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/core/constants/app_colors.dart';
import 'package:apprendchap/shared/widgets/widgets.dart';

class AccountTypeEnhancedPage extends StatefulWidget {
  const AccountTypeEnhancedPage({super.key});

  @override
  State<AccountTypeEnhancedPage> createState() =>
      _AccountTypeEnhancedPageState();
}

class _AccountTypeEnhancedPageState extends State<AccountTypeEnhancedPage> {
  String? _selectedAccountType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionWrapper(
        transitionType: PageTransitionType.fadeSlide,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  // En-tête
                  Text(
                    'Choisissez votre rôle',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Sélectionnez le type de compte qui vous convient le mieux',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // Carte Élève
                  AccountTypeCard(
                    title: 'Élève',
                    description: 'Apprendre et progresser',
                    detailedExplanation:
                        'Accédez à une plateforme complète d\'apprentissage avec des cours, des exercices et un suivi personnalisé de votre progression académique.',
                    features: [
                      'Accès à tous les cours et matières',
                      'Évaluation personnalisée des compétences',
                      'Suivi de la progression en temps réel',
                      'Ressources pédagogiques variées',
                      'Interaction avec d\'autres élèves',
                      'Recommandations d\'apprentissage',
                    ],
                    icon: Icons.person_outline,
                    isSelected: _selectedAccountType == 'student',
                    onTap: () {
                      setState(() => _selectedAccountType = 'student');
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Carte Parent
                  AccountTypeCard(
                    title: 'Parent',
                    description: 'Suivre la progression',
                    detailedExplanation:
                        'Restez informé de la progression académique de vos enfants avec un tableau de bord complet, des rapports détaillés et une communication directe avec les éducateurs.',
                    features: [
                      'Suivi en temps réel des résultats',
                      'Rapports de progression détaillés',
                      'Communication avec les éducateurs',
                      'Alertes et notifications',
                      'Historique complet des performances',
                      'Conseils d\'amélioration personnalisés',
                    ],
                    icon: Icons.family_restroom_outlined,
                    isSelected: _selectedAccountType == 'parent',
                    onTap: () {
                      setState(() => _selectedAccountType = 'parent');
                    },
                  ),
                  SizedBox(height: 16.h),
                  // Carte Partenaire
                  AccountTypeCard(
                    title: 'Partenaire',
                    description: 'Collaborer et partager',
                    detailedExplanation:
                        'Collaborez avec d\'autres professionnels pour créer du contenu pédagogique, partager des ressources et contribuer à l\'amélioration continue de la plateforme.',
                    features: [
                      'Création et partage de contenu',
                      'Outils de collaboration avancés',
                      'Accès à une communauté professionnelle',
                      'Analytics et statistiques détaillées',
                      'Support prioritaire',
                      'Opportunités de partenariat',
                    ],
                    icon: Icons.business_outlined,
                    isSelected: _selectedAccountType == 'partner',
                    onTap: () {
                      setState(() => _selectedAccountType = 'partner');
                    },
                  ),
                  SizedBox(height: 40.h),
                  // Boutons d'action
                  if (_selectedAccountType != null)
                    Column(
                      children: [
                        CustomButtonEnhanced(
                          text: 'Continuer',
                          onPressed: () {
                            if (_selectedAccountType == 'student') {
                              context.push('/signup-student-enhanced');
                            } else if (_selectedAccountType == 'parent') {
                              context.push('/signup-parent-enhanced');
                            } else if (_selectedAccountType == 'partner') {
                              context.push('/signup-partner-enhanced');
                            }
                          },
                          useGradient: true,
                        ),
                        SizedBox(height: 16.h),
                      ],
                    ),
                  CustomButtonEnhanced(
                    text: 'Retour',
                    onPressed: () => context.pop(),
                    useGradient: false,
                    backgroundColor: AppColors.surface,
                    textColor: AppColors.primary,
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
