import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:apprendchap/features/auth/presentation/pages/welcome_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/login_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/account_type_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/signup_student_stepper_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/signup_parent_stepper_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/signup_partner_stepper_page.dart';
import 'package:apprendchap/features/auth/presentation/pages/otp_verification_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: const Center(
        child: Text('Bienvenue sur ApprendChap'),
      ),
    );
  }
}

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const AccountTypePage(),
    ),
    GoRoute(
      path: '/signup-student',
      builder: (context, state) => const SignupStudentStepperPage(),
    ),
    GoRoute(
      path: '/signup-parent',
      builder: (context, state) => const SignupParentStepperPage(),
    ),
    GoRoute(
      path: '/signup-partner',
      builder: (context, state) => const SignupPartnerStepperPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      builder: (context, state) => const ForgotPasswordPage(),
    ),
    GoRoute(
      path: '/otp-verification',
      builder: (context, state) => const OtpVerificationPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
