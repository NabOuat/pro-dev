# 🎬 Guide : Switcher Animé et OTP au Téléphone

## 📋 Vue d'ensemble

Ce document décrit l'implémentation du switcher Email/Téléphone animé et l'envoi d'OTP au numéro de téléphone lors de l'inscription.

---

## ✨ 1. AnimatedToggleInput

**Fichier** : `lib/shared/widgets/animated_toggle_input.dart`

### Caractéristiques
- ✓ Animation fluide du switcher (400ms)
- ✓ Glissement horizontal du champ (slide animation)
- ✓ Icônes animées (email/téléphone)
- ✓ Validation en temps réel
- ✓ Feedback visuel au changement
- ✓ Courbes d'animation optimisées (easeInOutCubic)

### Utilisation

```dart
AnimatedToggleInput(
  emailHint: 'Entrez votre email',
  phoneHint: 'Entrez votre téléphone',
  emailLabel: 'Email',
  phoneLabel: 'Téléphone',
  emailController: emailController,
  phoneController: phoneController,
  emailValidator: (value) {
    if (value?.isEmpty ?? true) return 'Email requis';
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!)) {
      return 'Email invalide';
    }
    return null;
  },
  phoneValidator: (value) {
    if (value?.isEmpty ?? true) return 'Téléphone requis';
    if (value!.length < 10) return 'Téléphone invalide';
    return null;
  },
  onToggle: (useEmail) {
    print('Switched to: ${useEmail ? 'Email' : 'Téléphone'}');
  },
)
```

### Propriétés

| Propriété | Type | Description |
|-----------|------|-------------|
| `emailHint` | String | Placeholder pour le champ email |
| `phoneHint` | String | Placeholder pour le champ téléphone |
| `emailLabel` | String? | Label pour le champ email |
| `phoneLabel` | String? | Label pour le champ téléphone |
| `emailController` | TextEditingController | Contrôleur du champ email |
| `phoneController` | TextEditingController | Contrôleur du champ téléphone |
| `emailValidator` | Function? | Validateur pour l'email |
| `phoneValidator` | Function? | Validateur pour le téléphone |
| `onEmailChanged` | Function? | Callback au changement d'email |
| `onPhoneChanged` | Function? | Callback au changement de téléphone |
| `onToggle` | Function? | Callback au changement de mode |

---

## 📱 2. OtpVerificationEnhancedPage

**Fichier** : `lib/features/auth/presentation/pages/otp_verification_enhanced_page.dart`

### Caractéristiques
- ✓ 6 champs OTP avec navigation automatique
- ✓ Affichage du numéro de téléphone
- ✓ Compteur de renvoi (60 secondes)
- ✓ Bouton "Renvoyer" désactivé pendant le comptage
- ✓ Validation du code OTP complet
- ✓ Animation de transition fluide
- ✓ Feedback utilisateur amélioré

### Utilisation

```dart
// Naviguer vers la page OTP
context.push(
  '/otp-verification-enhanced',
  extra: {
    'phoneNumber': '+33612345678',
    'email': 'user@example.com',
  },
);

// Ou avec GoRouter
GoRoute(
  path: '/otp-verification-enhanced',
  builder: (context, state) {
    final extras = state.extra as Map<String, dynamic>;
    return OtpVerificationEnhancedPage(
      phoneNumber: extras['phoneNumber'],
      email: extras['email'],
    );
  },
),
```

### Flux d'Utilisation

1. **Affichage du numéro** : Le numéro de téléphone est affiché pour confirmation
2. **Saisie OTP** : L'utilisateur entre les 6 chiffres
3. **Navigation automatique** : Le focus passe automatiquement au champ suivant
4. **Vérification** : Clic sur "Vérifier" pour valider le code
5. **Renvoi** : Après 60 secondes, l'utilisateur peut renvoyer le code

### Propriétés

| Propriété | Type | Description |
|-----------|------|-------------|
| `phoneNumber` | String | Numéro de téléphone pour l'OTP |
| `email` | String? | Email optionnel |

---

## 🔄 3. Pages Mises à Jour

### LoginEnhancedPage
- ✓ Utilise `AnimatedToggleInput` au lieu du toggle manuel
- ✓ Animation fluide du switcher
- ✓ Validation en temps réel

### ForgotPasswordEnhancedPage
- ✓ Utilise `AnimatedToggleInput` au lieu du toggle manuel
- ✓ Animation fluide du switcher
- ✓ Validation en temps réel

### SignupStudentStepperEnhancedPage
- ✓ Intégration prévue pour l'envoi d'OTP au téléphone
- ✓ Navigation vers `OtpVerificationEnhancedPage` avec le numéro de téléphone

---

## 🎯 Implémentation de l'Envoi d'OTP au Téléphone

### Dans le Stepper Élève

```dart
void _handleSubmit() {
  if (_validateCurrentStep()) {
    setState(() => _isLoading = true);
    
    // Récupérer le numéro de téléphone
    final phoneNumber = _phoneController.text;
    
    // Simuler l'envoi d'OTP
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _isLoading = false);
        
        // Naviguer vers la page OTP avec le numéro
        context.push(
          '/otp-verification-enhanced',
          extra: {
            'phoneNumber': phoneNumber,
            'email': _emailController.text,
          },
        );
      }
    });
  }
}
```

### Mise à Jour des Routes

```dart
// Dans app_router.dart
GoRoute(
  path: '/otp-verification-enhanced',
  builder: (context, state) {
    final extras = state.extra as Map<String, dynamic>;
    return OtpVerificationEnhancedPage(
      phoneNumber: extras['phoneNumber'],
      email: extras['email'],
    );
  },
),
```

---

## 🎨 Animations Détaillées

### AnimatedToggleInput

**Durée** : 400ms

**Animations** :
1. **Switcher** : AnimatedContainer (300ms)
   - Couleur de fond change
   - Icônes changent de couleur
   
2. **Champ** : Transform + Opacity (400ms)
   - Glissement horizontal (+20 pixels)
   - Opacité diminue à 70%
   - Courbe : easeInOutCubic

### OtpVerificationEnhancedPage

**Durée** : 400ms

**Animations** :
1. **Page** : PageTransitionWrapper (fadeSlide)
   - Fade in (opacité 0 → 1)
   - Slide up (offset 0.1 → 0)

2. **Champs OTP** : Focus animation
   - Couleur de fond change au focus
   - Bordure change de couleur

---

## 📊 Comparaison Avant/Après

| Aspect | Avant | Après |
|--------|-------|-------|
| **Switcher** | Boutons statiques | Animation fluide (400ms) |
| **Champ** | Changement instantané | Glissement animé |
| **OTP** | Page simple | Page améliorée avec compteur |
| **Feedback** | Basique | Icônes et couleurs |
| **Navigation** | Manuelle | Automatique entre champs |

---

## 🔧 Configuration des Routes

```dart
// app_router.dart
GoRoute(
  path: '/login-enhanced',
  builder: (context, state) => const LoginEnhancedPage(),
),
GoRoute(
  path: '/forgot-password-enhanced',
  builder: (context, state) => const ForgotPasswordEnhancedPage(),
),
GoRoute(
  path: '/otp-verification-enhanced',
  builder: (context, state) {
    final extras = state.extra as Map<String, dynamic>?;
    return OtpVerificationEnhancedPage(
      phoneNumber: extras?['phoneNumber'] ?? '',
      email: extras?['email'],
    );
  },
),
```

---

## 📝 Checklist d'Intégration

- [ ] Exporter `AnimatedToggleInput` dans `widgets.dart`
- [ ] Exporter `OtpVerificationEnhancedPage` dans `pages.dart`
- [ ] Mettre à jour `app_router.dart` avec les nouvelles routes
- [ ] Tester le switcher animé sur différentes tailles d'écran
- [ ] Tester la navigation automatique des champs OTP
- [ ] Vérifier le compteur de renvoi (60 secondes)
- [ ] Tester l'envoi d'OTP au téléphone
- [ ] Vérifier les animations sur appareils réels

---

## 🎯 Prochaines Étapes

1. **Intégration Backend** : Connecter l'envoi d'OTP à un service SMS
2. **Validation OTP** : Implémenter la vérification du code côté serveur
3. **Gestion d'Erreurs** : Ajouter des messages d'erreur pour les codes invalides
4. **Retry Logic** : Implémenter la logique de réessai après 3 tentatives
5. **Biométrie** : Ajouter une option de vérification biométrique

---

**Version** : 1.0.0  
**Date** : Décembre 2024  
**Statut** : ✅ Complété
