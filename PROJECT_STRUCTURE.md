# 📱 ApprendChap - Structure du Projet Complète

## 🎯 Vue d'ensemble

**ApprendChap** est une application Flutter mobile pour l'apprentissage en ligne avec trois types de comptes (Élève, Parent, Partenaire). L'application est entièrement en français et optimisée pour mobile avec une inscription en stepper multi-étapes, sélection de série dynamique, notation avec emojis réactifs, et support Post-Bac académique.

**Signification** : ApprendChap = Apprendre Rapidement

**Version** : 2.0.0 (Avec Stepper et Matières Dynamiques)

---

## 📂 Structure Complète du Projet

```
apprendchap/
├── lib/
│   ├── main.dart                          # Point d'entrée de l'application
│   ├── core/                              # Logique métier et configuration
│   │   ├── constants/
│   │   │   ├── constants.dart             # Constantes globales (grades, matières, types d'activité)
│   │   │   ├── app_colors.dart            # Palette de couleurs
│   │   │   └── academic_data.dart         # 🆕 Données académiques (séries, matières, Post-Bac, emojis)
│   │   ├── localization/
│   │   │   └── app_strings.dart           # Tous les textes en français (100+ chaînes)
│   │   ├── theme/
│   │   │   └── theme.dart                 # Thème et couleurs
│   │   └── utils/
│   │       └── utils.dart                 # Fonctions utilitaires
│   ├── features/                          # Fonctionnalités métier
│   │   └── auth/                          # Feature d'authentification
│   │       ├── data/
│   │       │   └── data.dart              # Couche données (API, DB)
│   │       ├── domain/
│   │       │   └── domain.dart            # Logique métier
│   │       ├── presentation/
│   │       │   ├── bloc/
│   │       │   │   └── bloc.dart          # Gestion d'état BLoC
│   │       │   └── pages/
│   │       │       ├── welcome_page.dart                    # Page d'accueil avec SVG
│   │       │       ├── login_page.dart                      # Connexion (email/téléphone) avec SVG
│   │       │       ├── forgot_password_page.dart            # Réinitialisation mot de passe
│   │       │       ├── account_type_page.dart               # Sélection type de compte avec SVG
│   │       │       ├── signup_student_stepper_page.dart     # 🆕 Stepper élève (5 étapes)
│   │       │       ├── signup_parent_stepper_page.dart      # 🆕 Stepper parent (3 étapes)
│   │       │       ├── signup_partner_stepper_page.dart     # 🆕 Stepper partenaire (4 étapes)
│   │       │       ├── signup_student_page.dart            # ⚠️ Ancien (à supprimer)
│   │       │       ├── signup_parent_page.dart             # ⚠️ Ancien (à supprimer)
│   │       │       ├── signup_partner_page.dart            # ⚠️ Ancien (à supprimer)
│   │       │       ├── otp_verification_page.dart           # Vérification OTP
│   │       │       └── pages.dart                           # Exports des pages
│   │       ├── presentation.dart          # Export de la couche présentation
│   │       └── auth.dart                  # Export de la feature
│   ├── routes/
│   │   ├── app_router.dart                # Configuration GoRouter (tous les chemins)
│   │   └── routes.dart                    # Exports
│   ├── shared/                            # Composants réutilisables
│   │   ├── widgets/
│   │   │   ├── custom_button.dart         # Bouton moderne avec loading
│   │   │   ├── custom_text_field.dart     # Champ texte avec validation
│   │   │   ├── toggle_input.dart          # Switcher Email/Téléphone
│   │   │   ├── star_rating.dart           # Notation sur 5 étoiles simple
│   │   │   ├── animated_star_rating.dart  # 🆕 Notation avec emojis et couleurs réactifs
│   │   │   ├── social_button.dart         # Boutons réseaux sociaux
│   │   │   ├── svg_image.dart             # Wrapper pour SVG
│   │   │   ├── widgets.dart               # Exports des widgets
│   │   │   └── widgets/                   # Dossier des widgets
│   │   ├── shared.dart                    # Export principal
│   │   └── shared_exports.dart            # Exports alternatifs
│   ├── features.dart                      # Export de toutes les features
│   └── core.dart                          # Export du core
├── assets/
│   ├── icons/
│   │   ├── chat.svg                       # Icône chat (Account Type)
│   │   ├── login.svg                      # Icône login
│   │   ├── signup.svg                     # Icône signup
│   │   ├── google-plus.svg                # Icône Google
│   │   ├── facebook.svg                   # Icône Facebook
│   │   └── twitter.svg                    # Icône Twitter
│   └── images/
│       ├── main_top.png                   # Image Welcome Page
│       ├── main_bottom.png                # Image Welcome Page
│       ├── login_bottom.png               # Image Login Page
│       └── signup_top.png                 # Image Signup Page
├── pubspec.yaml                           # Dépendances et configuration
├── analysis_options.yaml                  # Règles de lint
├── README.md                              # Documentation générale
├── FEATURES.md                            # Documentation des fonctionnalités
└── PROJECT_STRUCTURE.md                   # Ce fichier
```

---

## 📄 Description Détaillée des Fichiers

### 🔴 Core (Logique Métier et Configuration)

#### `lib/core/constants/academic_data.dart` 🆕
**Contient** : Données académiques complètes pour l'inscription des élèves

**Classes et Données** :
- `AcademicData.allGrades` : Toutes les classes disponibles
  - Primaire : CP1, CP2, CE1, CE2, CM1, CM2
  - Collège : 6ème, 5ème, 4ème, 3ème
  - Lycée : 2nde, 1ère, Terminale
  - Supérieur : BTS

- `AcademicData.seriesByGrade` : Séries disponibles par classe (lycée uniquement)
  - 2nde : ['Générale']
  - 1ère : ['A1', 'A2', 'C', 'D', 'TI']
  - Terminale : ['A1', 'A2', 'C', 'D', 'TI']

- `AcademicData.subjectsBySerie` : Matières principales par série (lycée)
  - Générale : [Français, Mathématiques, Anglais, Sciences, Histoire-Géographie]
  - A1/A2 : [Français, Philosophie, Histoire-Géographie, Anglais, Littérature]
  - C/D : [Mathématiques, Physique-Chimie, Sciences de la Vie, Anglais, Français]
  - TI : [Mathématiques, Informatique, Électronique, Anglais, Français]

- `AcademicData.subjectsByGrade` : Matières par classe (primaire et collège)
  - CP1-CE2 : [Français, Mathématiques, Sciences, Éducation Physique, Arts Plastiques]
  - CM1-CM2 : [Français, Mathématiques, Sciences, Histoire-Géographie, Éducation Physique]
  - 6ème-3ème : [Français, Mathématiques, Sciences, Histoire-Géographie, Anglais]

- `AcademicData.btsYears` : Années BTS
  - ['1ère année', '2ème année']

- `AcademicData.btsFiliere` : 10 filières BTS
  - Informatique, Électronique, Mécanique, Gestion, Comptabilité, Commerce, Tourisme, Hôtellerie, Santé, Autre

- `AcademicData.subjectsByBtsFiliere` : Matières spécifiques par filière BTS
  - Exemple : Informatique = [Programmation, Bases de Données, Réseaux, Cybersécurité]

- `AcademicData.businessTypes` : Types d'activité pour les partenaires
  - [École, Centre de formation, Organisme d'éducation, Influenceur, Blogueur, Autre]

- `RatingData.ratingInfo` : Données emojis et couleurs réactifs
  - 1 : 😢 (Rouge #EF4444) = Très faible
  - 2 : 😕 (Ambre #F59E0B) = Faible
  - 3 : 😐 (Jaune #FBBf24) = Moyen
  - 4 : 😊 (Vert #10B981) = Bon
  - 5 : 🤩 (Indigo #6366F1) = Excellent

**Utilisation** : Importer et utiliser pour les dropdowns et la notation dynamique
```dart
import 'package:apprendchap/core/constants/academic_data.dart';

// Récupérer les matières selon la classe
List<String> subjects = AcademicData.subjectsByGrade['6ème'] ?? [];

// Récupérer les filières BTS
List<String> filieres = AcademicData.btsFiliere;

// Récupérer les infos de notation
var ratingInfo = RatingData.ratingInfo[4]; // Récupère 😊 Bon
```

**Modification** : Ajouter de nouvelles classes, séries, filières BTS ou matières ici

### 🔴 Core (Logique Métier)

#### `lib/core/constants/constants.dart`
**Contient** : Constantes globales
- `AppConstants` class avec :
  - `appName`, `appVersion`
  - `defaultPadding`, `defaultBorderRadius`
  - `animationDuration`
  - Listes : `grades`, `mainSubjects`, `businessTypes`

**Modification** : Ajouter des constantes globales ici

#### `lib/core/constants/app_colors.dart`
**Contient** : Palette de couleurs
- Couleurs primaires : `primary` (#6366F1), `secondary` (#8B5CF6), `tertiary` (#F59E0B)
- Couleurs de texte : `textPrimary`, `textSecondary`, `textTertiary`
- Couleurs d'état : `error`, `success`, `warning`, `info`

**Modification** : Changer les couleurs globales ici

#### `lib/core/localization/app_strings.dart`
**Contient** : Tous les textes en français (100+ chaînes)
- Sections : Welcome, Login, Forgot Password, Account Types, Signup, OTP, Validation, Common
- Format : `static const String nomVariable = 'Texte français'`

**Modification** : Ajouter/modifier du texte → chercher ici

#### `lib/core/theme/theme.dart`
**Contient** : Thème et couleurs (classe `AppTheme`)
- Couleurs primaires et secondaires
- Couleurs de texte
- Couleurs de bordure et divider

**Modification** : Changer le thème global → ici

### 🟢 Features (Fonctionnalités)

#### `lib/features/auth/presentation/pages/welcome_page.dart`
**Affiche** :
- Badge "ApprendChap" en haut
- Image main_top.png
- Titre "Bienvenue sur ApprendChap"
- Sous-titre "(Apprendre rapidement)"
- Boutons "Commencer" et "Créer un compte"
- Image main_bottom.png

**Modification** : Changer le texte de bienvenue → `AppStrings` dans `app_strings.dart`

#### `lib/features/auth/presentation/pages/login_page.dart`
**Affiche** :
- AppBar avec "ApprendChap"
- Icône login (Icons.login_outlined)
- ToggleInput (Email/Téléphone)
- Champ mot de passe
- Lien "Mot de passe oublié"
- Boutons réseaux sociaux (Google, Facebook)
- Lien "Créer un compte"

**Modification** :
- Changer validation → modifier les `validator` functions
- Ajouter API login → modifier `_handleLogin()`
- Changer couleurs → utiliser `AppColors`

#### `lib/features/auth/presentation/pages/forgot_password_page.dart`
**Affiche** :
- AppBar avec "ApprendChap"
- ToggleInput (Email/Téléphone)
- Bouton "Envoyer le lien"
- Écran de confirmation après envoi

**Modification** :
- Changer le texte → `AppStrings`
- Ajouter API d'envoi → modifier `_handleSendReset()`

#### `lib/features/auth/presentation/pages/account_type_page.dart`
**Affiche** :
- AppBar avec "ApprendChap"
- Icône chat (Icons.chat_outlined)
- 3 cartes pour sélectionner le type de compte :
  - Élève (Indigo)
  - Parent (Violet)
  - Partenaire (Ambre)

**Modification** :
- Changer les descriptions → `AppStrings`
- Ajouter un 4e type → ajouter une `_AccountTypeCard` et créer la page correspondante

#### `lib/features/auth/presentation/pages/signup_student_stepper_page.dart` 🆕
**Affiche** : Stepper d'inscription en 5 étapes pour les élèves (CP1 à Terminale + BTS)

**Étape 1 - Informations Personnelles** :
- Nom complet (TextEditingController: `_fullNameController`)
- Email (TextEditingController: `_emailController`)
- Téléphone (TextEditingController: `_phoneController`)

**Étape 2 - Classe et Options** :
- Dropdown Classe : Toutes les classes (CP1, CP2, CE1, CE2, CM1, CM2, 6ème, 5ème, 4ème, 3ème, 2nde, 1ère, Terminale, BTS)
- Si Lycée (2nde, 1ère, Terminale) :
  - Dropdown Série (dynamique selon classe) : Générale, A1, A2, C, D, TI
- Si BTS :
  - Dropdown Année : ['1ère année', '2ème année']
  - Dropdown Filière : [Informatique, Électronique, Mécanique, Gestion, Comptabilité, Commerce, Tourisme, Hôtellerie, Santé, Autre]

**Étape 3 - Évaluation des Matières** :
- Utilise `AnimatedStarRating` pour chaque matière
- Les matières changent selon :
  - La classe (CP1-3ème) → matières de `AcademicData.subjectsByGrade`
  - La série (2nde-Terminale) → matières de `AcademicData.subjectsBySerie`
  - La filière BTS → matières de `AcademicData.subjectsByBtsFiliere`
- Stockage : `Map<String, int> _subjectRatings`
- Validation : Toutes les matières doivent être notées

**Étape 4 - Sécurité du Compte** :
- Mot de passe (TextEditingController: `_passwordController`)
- Confirmation mot de passe (TextEditingController: `_confirmPasswordController`)
- Toggle visibilité pour chaque champ
- Validation : Min 8 caractères, correspondance

**Étape 5 - Code de Parrainage** :
- Code de parrainage optionnel (TextEditingController: `_referralCodeController`)
- Résumé des informations saisies
- Bouton "Terminer" → OTP Verification

**Fonctionnalités** :
- Barre de progression (5 étapes)
- Boutons Précédent/Suivant
- Validation à chaque étape
- Matières dynamiques selon classe/série/filière BTS
- Résumé avant soumission

**Variables d'État** :
- `_selectedGrade` : Classe sélectionnée
- `_selectedSerie` : Série (lycée uniquement)
- `_selectedBtsYear` : Année BTS
- `_selectedBtsFiliere` : Filière BTS

**Modification** :
- Ajouter une classe → modifier `AcademicData.allGrades`
- Ajouter une filière BTS → modifier `AcademicData.btsFiliere` et `AcademicData.subjectsByBtsFiliere`
- Changer les matières → modifier `AcademicData.subjectsByGrade`, `AcademicData.subjectsBySerie` ou `AcademicData.subjectsByBtsFiliere`

#### `lib/features/auth/presentation/pages/signup_parent_stepper_page.dart` 🆕
**Affiche** : Stepper d'inscription en 3 étapes pour les parents

**Étape 1 - Informations Personnelles** :
- Nom complet (TextEditingController: `_fullNameController`)
- Email (TextEditingController: `_emailController`)
- Téléphone (TextEditingController: `_phoneController`)

**Étape 2 - Sécurité du Compte** :
- Mot de passe (TextEditingController: `_passwordController`)
- Confirmation mot de passe (TextEditingController: `_confirmPasswordController`)
- Toggle visibilité pour chaque champ

**Étape 3 - Gestion des Enfants** :
- Information : "Vous pouvez ajouter les enfants plus tard"
- Résumé des informations saisies
- Bouton "Terminer" → OTP Verification

**Fonctionnalités** :
- Barre de progression (3 étapes, couleur violet #8B5CF6)
- Boutons Précédent/Suivant
- Validation à chaque étape
- Résumé avant soumission

**Modification** :
- Ajouter un champ → ajouter un `TextEditingController` et le valider
- Changer la couleur → modifier `backgroundColor: const Color(0xFF8B5CF6)`

#### `lib/features/auth/presentation/pages/signup_partner_stepper_page.dart` 🆕
**Affiche** : Stepper d'inscription en 4 étapes pour les partenaires

**Étape 1 - Informations Entreprise** :
- Nom de l'entreprise (TextEditingController: `_companyNameController`)
- Personne de contact (TextEditingController: `_contactPersonController`)
- Type d'activité (Dropdown: `_selectedBusinessType`)
  - Utilise `AcademicData.businessTypes`

**Étape 2 - Coordonnées** :
- Email (TextEditingController: `_emailController`)
- Téléphone (TextEditingController: `_phoneController`)

**Étape 3 - Sécurité du Compte** :
- Mot de passe (TextEditingController: `_passwordController`)
- Confirmation mot de passe (TextEditingController: `_confirmPasswordController`)
- Toggle visibilité pour chaque champ

**Étape 4 - Informations Commission** :
- Information sur le programme de commission
- Résumé des informations saisies
- Bouton "Terminer" → OTP Verification

**Fonctionnalités** :
- Barre de progression (4 étapes, couleur ambre #F59E0B)
- Boutons Précédent/Suivant
- Validation à chaque étape
- Résumé avant soumission

**Modification** :
- Ajouter un type d'activité → modifier `AcademicData.businessTypes`
- Changer la couleur → modifier `backgroundColor: const Color(0xFFF59E0B)`

#### `lib/features/auth/presentation/pages/otp_verification_page.dart`
**Affiche** :
- AppBar avec "ApprendChap"
- Icône mail (Icons.mail_outline)
- 6 champs pour saisir le code OTP
- Bouton "Vérifier"
- Compteur de renvoi (60 secondes)
- Bouton "Renvoyer le code"

**Modification** :
- Changer le nombre de champs OTP → modifier `List.generate(6, ...)`
- Ajouter API OTP → modifier `_handleVerify()`

### 🔵 Routes (Navigation)

#### `lib/routes/app_router.dart`
**Contient** : Configuration GoRouter avec tous les chemins
- `/` → WelcomePage
- `/login` → LoginPage
- `/signup` → AccountTypePage
- `/signup-student` → SignupStudentPage
- `/signup-parent` → SignupParentPage
- `/signup-partner` → SignupPartnerPage
- `/forgot-password` → ForgotPasswordPage
- `/otp-verification` → OtpVerificationPage
- `/home` → HomePage

**Modification** :
- Ajouter une nouvelle page → ajouter un `GoRoute` ici
- Changer un chemin → modifier le `path` du `GoRoute`
- Ajouter des paramètres → utiliser `GoRoute` avec `$id` et `builder` parameters

### 🟡 Shared Widgets (Composants Réutilisables)

#### `lib/shared/widgets/custom_button.dart`
**Propriétés** :
- `text` : Texte du bouton
- `onPressed` : Callback au clic
- `backgroundColor` : Couleur de fond (défaut : indigo)
- `textColor` : Couleur du texte (défaut : blanc)
- `isLoading` : Affiche un spinner si true
- `height` : Hauteur (défaut : 56)

**Utilisation** :
```dart
CustomButton(
  text: 'Continuer',
  onPressed: () => context.push('/next'),
  backgroundColor: const Color(0xFF6366F1),
)
```

#### `lib/shared/widgets/custom_text_field.dart`
**Propriétés** :
- `hintText` : Texte d'indication
- `labelText` : Étiquette
- `controller` : TextEditingController
- `obscureText` : Masquer le texte (pour mots de passe)
- `validator` : Fonction de validation
- `prefixIcon` : Icône avant le texte
- `suffixIcon` : Icône après le texte

**Utilisation** :
```dart
CustomTextField(
  hintText: 'Entrez votre email',
  labelText: 'Email',
  controller: _emailController,
  prefixIcon: const Icon(Icons.email_outlined),
  validator: (value) => value?.isEmpty ?? true ? 'Requis' : null,
)
```

#### `lib/shared/widgets/toggle_input.dart`
**Propriétés** :
- `emailHint` / `phoneHint` : Textes d'indication
- `emailController` / `phoneController` : Contrôleurs
- `emailValidator` / `phoneValidator` : Validations

**Utilisation** :
```dart
ToggleInput(
  emailHint: 'Entrez votre email',
  phoneHint: 'Entrez votre téléphone',
  emailController: _emailController,
  phoneController: _phoneController,
)
```

#### `lib/shared/widgets/star_rating.dart`
**Propriétés** :
- `label` : Nom de la matière
- `onRatingChanged` : Callback avec la note (1-5)
- `initialRating` : Note initiale

**Utilisation** :
```dart
StarRating(
  label: 'Mathématiques',
  onRatingChanged: (rating) {
    setState(() => _ratings['Mathématiques'] = rating);
  },
)
```

#### `lib/shared/widgets/animated_star_rating.dart` 🆕
**Propriétés** :
- `label` : Nom de la matière
- `onRatingChanged` : Callback avec la note (1-5)
- `initialRating` : Note initiale

**Fonctionnalités** :
- Animation élastique au clic (ScaleTransition)
- Emojis réactifs : 😢 😕 😐 😊 🤩
- Couleurs dynamiques selon le niveau
- Labels : Très faible → Excellent
- Affichage du niveau à droite des étoiles

**Utilisation** :
```dart
AnimatedStarRating(
  label: 'Mathématiques',
  initialRating: 0,
  onRatingChanged: (rating) {
    setState(() => _subjectRatings['Mathématiques'] = rating);
  },
)
```

**Données Utilisées** :
- `RatingData.ratingInfo` de `academic_data.dart` pour les emojis et couleurs

#### `lib/shared/widgets/social_button.dart`
**Propriétés** :
- `iconPath` : Chemin du SVG
- `label` : Texte du bouton
- `onPressed` : Callback au clic

**Utilisation** :
```dart
SocialButton(
  iconPath: 'assets/icons/google-plus.svg',
  label: 'Google',
  onPressed: () => _handleGoogleLogin(),
)
```

---

## 🎨 Main.dart (Point d'Entrée)

**Contient** :
- `MyApp` : Widget racine
- Configuration `ScreenUtilInit` (responsive design)
- Configuration `MaterialApp.router` avec GoRouter
- Thème global avec `ColorScheme.fromSeed`
- AppBar personnalisée

**Modification** :
- Changer la couleur primaire → modifier `seedColor` dans `ColorScheme.fromSeed`
- Ajouter un thème personnalisé → modifier `ThemeData`

---

## 📦 Pubspec.yaml

**Dépendances principales** :
- `flutter_screenutil: ^5.9.3` - Responsive design
- `go_router: ^17.0.1` - Navigation
- `flutter_bloc: ^9.1.1` - Gestion d'état
- `flutter_svg: ^2.0.0` - Support SVG
- `shared_preferences: ^2.5.4` - Stockage local
- `dio: ^5.9.0` - Requêtes HTTP

**Modification** :
- Ajouter une dépendance → ajouter sous `dependencies:`
- Mettre à jour une version → modifier le numéro de version

---

## 🔄 Flux de Navigation

```
Welcome Page
    ↓
    ├→ Login Page ←→ Forgot Password Page → OTP Verification
    │       ↓
    │   Home Page
    │
    └→ Account Type Selection
        ├→ Signup Student Page → OTP Verification
        ├→ Signup Parent Page → OTP Verification
        └→ Signup Partner Page → OTP Verification
                ↓
            Home Page
```

---

## 🔍 Guide de Modification Complet

### 🆕 Ajouter une classe (primaire/collège)

1. Aller dans `lib/core/constants/academic_data.dart`
2. Ajouter la classe à `allGrades` :
```dart
static const List<String> allGrades = [
  'CP1', 'CP2', 'CE1', 'CE2', 'CM1', 'CM2',
  '6ème', '5ème', '4ème', '3ème',
  '2nde', '1ère', 'Terminale',
  'BTS',
  'Nouvelle Classe',  // ← Ajouter ici
];
```
3. Ajouter les matières correspondantes à `subjectsByGrade` :
```dart
'Nouvelle Classe': ['Matière 1', 'Matière 2', 'Matière 3', 'Matière 4', 'Matière 5'],
```

### 🆕 Ajouter une matière (pour les élèves)

1. Aller dans `lib/core/constants/academic_data.dart`
2. Pour une classe (primaire/collège), modifier `subjectsByGrade` :
```dart
'6ème': [
  'Français',
  'Mathématiques',
  'Sciences',
  'Histoire-Géographie',
  'Anglais',
  'Nouvelle Matière',  // ← Ajouter ici
],
```
3. Pour une série (lycée), modifier `subjectsBySerie` :
```dart
'C': [
  'Mathématiques',
  'Physique-Chimie',
  'Sciences de la Vie',
  'Anglais',
  'Français',
  'Nouvelle Matière',  // ← Ajouter ici
],
```
4. La matière apparaîtra automatiquement dans le stepper

### 🆕 Ajouter une filière BTS

1. Aller dans `lib/core/constants/academic_data.dart`
2. Ajouter la filière à `btsFiliere` :
```dart
static const List<String> btsFiliere = [
  'Informatique',
  'Électronique',
  'Mécanique',
  'Gestion',
  'Comptabilité',
  'Commerce',
  'Tourisme',
  'Hôtellerie',
  'Santé',
  'Autre',
  'Nouvelle Filière',  // ← Ajouter ici
];
```
3. Ajouter les matières correspondantes à `subjectsByBtsFiliere` :
```dart
'Nouvelle Filière': ['Matière 1', 'Matière 2', 'Matière 3', 'Matière 4'],
```
4. La filière apparaîtra automatiquement dans le dropdown BTS du stepper

### 🆕 Ajouter un type d'activité (pour les partenaires)

1. Aller dans `lib/core/constants/academic_data.dart`
2. Modifier la liste `businessTypes` :
```dart
static const List<String> businessTypes = [
  'École',
  'Centre de formation',
  'Nouveau Type',  // ← Ajouter ici
];
```
3. Le type apparaîtra automatiquement dans le dropdown du stepper partenaire

### 🆕 Changer les couleurs des emojis/notes

1. Aller dans `lib/core/constants/academic_data.dart`
2. Modifier `RatingData.ratingInfo` :
```dart
static const Map<int, Map<String, dynamic>> ratingInfo = {
  1: {
    'emoji': '😢',
    'color': 0xFFEF4444,  // ← Modifier la couleur (format hex)
    'label': 'Très faible',
  },
};
```
3. Les couleurs et emojis se mettront à jour automatiquement

### Ajouter une nouvelle page

1. **Créer le fichier** : `lib/features/auth/presentation/pages/new_page.dart`
2. **Créer la classe** : `class NewPage extends StatelessWidget`
3. **Ajouter la route** : Dans `lib/routes/app_router.dart`
4. **Exporter** : Dans `lib/features/auth/presentation/pages/pages.dart`

### Changer un texte

1. Aller dans `lib/core/localization/app_strings.dart`
2. Trouver la chaîne avec `Ctrl+F`
3. Modifier la valeur
4. Utiliser `AppStrings.nomVariable` dans les pages

### Changer une couleur

1. Aller dans `lib/core/constants/app_colors.dart`
2. Modifier la couleur dans `AppColors` class
3. Utiliser `AppColors.nomCouleur` dans les pages

### Ajouter une validation

1. Aller dans la page (ex: `login_page.dart`)
2. Modifier la fonction `validator` du champ
3. Retourner un message d'erreur ou `null` si valide

### Ajouter une étape au stepper élève

1. Aller dans `lib/features/auth/presentation/pages/signup_student_stepper_page.dart`
2. Ajouter une méthode `_buildStepX()` :
```dart
Widget _buildStep6() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Nouvelle Étape', style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w800)),
      // Contenu de l'étape
    ],
  );
}
```
3. Ajouter la condition dans le build :
```dart
if (_currentStep == 5) _buildStep6(),
```
4. Modifier le nombre d'étapes dans la barre de progression (5 → 6)

### Ajouter un type de compte

1. Créer une nouvelle page stepper : `signup_newtype_stepper_page.dart`
2. Ajouter une route dans `app_router.dart`
3. Ajouter une `_AccountTypeCard` dans `account_type_page.dart`
4. Importer la nouvelle page dans `app_router.dart`

---

## 🎯 Fichiers Clés par Tâche

| Tâche | Fichier(s) |
|-------|-----------|
| Changer le texte | `app_strings.dart` |
| Changer les couleurs | `app_colors.dart` |
| Ajouter une classe (primaire/collège) | `academic_data.dart` (allGrades + subjectsByGrade) |
| Ajouter une matière | `academic_data.dart` (subjectsByGrade ou subjectsBySerie ou subjectsByBtsFiliere) |
| Ajouter une filière BTS | `academic_data.dart` (btsFiliere + subjectsByBtsFiliere) |
| Ajouter un type d'activité partenaire | `academic_data.dart` (businessTypes) |
| Changer les emojis/couleurs des notes | `academic_data.dart` (RatingData.ratingInfo) |
| Ajouter une étape au stepper | Page stepper concernée (`signup_student_stepper_page.dart`, etc.) |
| Ajouter une page | `pages/new_page.dart` + `app_router.dart` + `pages.dart` |
| Modifier la validation | Page concernée (`login_page.dart`, etc.) |
| Ajouter un champ | Page concernée + `custom_text_field.dart` |
| Changer la navigation | `app_router.dart` |
| Ajouter un type de compte | `account_type_page.dart` + nouvelle page stepper + `app_router.dart` |
| Changer le thème | `main.dart` + `app_colors.dart` |
| Ajouter une API | Page concernée + `data/` layer |
| Utiliser AnimatedStarRating | Importer depuis `animated_star_rating.dart` + utiliser `RatingData` |

---

## 📊 Statistiques du Projet (v2.1.0)

- **Pages d'authentification** : 8 pages
  - Welcome, Login, Forgot Password, Account Type, OTP Verification
  - Stepper Élève (5 étapes), Stepper Parent (3 étapes), Stepper Partenaire (4 étapes)
- **Widgets réutilisables** : 7 widgets
  - CustomButton, CustomTextField, ToggleInput, StarRating, AnimatedStarRating, SocialButton, SvgImage
- **Fichiers de configuration** : 2 fichiers
  - `academic_data.dart` (Données académiques complètes)
  - `app_strings.dart` (100+ textes français)
- **Fichiers Dart** : 35+
- **Lignes de code** : 3500+
- **Textes français** : 100+
- **Couleurs** : 12+ couleurs définies
- **Routes** : 9 routes
- **Classes disponibles** : 14 classes
  - Primaire : CP1, CP2, CE1, CE2, CM1, CM2 (6)
  - Collège : 6ème, 5ème, 4ème, 3ème (4)
  - Lycée : 2nde, 1ère, Terminale (3)
  - Supérieur : BTS (1)
- **Séries lycée** : 5 séries (Générale, A1, A2, C, D, TI)
- **Filières BTS** : 10 filières (Informatique, Électronique, Mécanique, Gestion, Comptabilité, Commerce, Tourisme, Hôtellerie, Santé, Autre)
- **Années BTS** : 2 années (1ère année, 2ème année)
- **Types d'activité partenaire** : 6 types
- **Niveaux de notation** : 5 niveaux avec emojis et couleurs

---

## ✅ Checklist de Déploiement

- [ ] Exécuter `flutter pub get`
- [ ] Exécuter `flutter pub upgrade`
- [ ] Vérifier les erreurs de lint : `flutter analyze`
- [ ] Tester sur Android : `flutter run`
- [ ] Tester sur iOS : `flutter run -d iphone`
- [ ] Vérifier les performances
- [ ] Tester l'OTP réel (Firebase/Twilio)
- [ ] Intégrer les APIs backend
- [ ] Configurer les variables d'environnement
- [ ] Générer les APK/IPA

---

## � Flux de Données Stepper Élève

```
Étape 1 (Infos Perso)
  ↓ Validation
Étape 2 (Classe/Domaine)
  ↓ Sélection série/domaine
  ↓ Récupération matières dynamiques
Étape 3 (Notation)
  ↓ Utilise AnimatedStarRating
  ↓ Stockage dans Map<String, int>
Étape 4 (Mot de passe)
  ↓ Validation sécurité
Étape 5 (Parrainage)
  ↓ Résumé + Validation finale
  ↓ Soumission → OTP Verification
```

---

## 📚 Architecture Modulaire

**Séparation des Responsabilités** :
- `academic_data.dart` : Données académiques (centralisées)
- `animated_star_rating.dart` : Widget de notation (réutilisable)
- `signup_student_stepper_page.dart` : Logique inscription élève
- `signup_parent_stepper_page.dart` : Logique inscription parent
- `signup_partner_stepper_page.dart` : Logique inscription partenaire

**Avantages** :
- ✅ Pas de condensation dans un seul fichier
- ✅ Réutilisabilité des composants
- ✅ Maintenance facilitée
- ✅ Tests unitaires possibles
- ✅ Évolutivité accrue

---

## 🎯 Prochaines Étapes Recommandées

1. **Intégration API** :
   - Créer les endpoints backend pour chaque stepper
   - Implémenter l'authentification JWT
   - Ajouter la gestion des erreurs réseau

2. **Stockage Local** :
   - Implémenter SharedPreferences pour les données utilisateur
   - Ajouter la persistance des brouillons de formulaire

3. **Améliorations UX** :
   - Ajouter des animations de transition entre étapes
   - Implémenter la sauvegarde automatique des données
   - Ajouter des indicateurs de progression visuels

4. **Tests** :
   - Créer des tests unitaires pour les validations
   - Implémenter des tests d'intégration
   - Tester les différents flux utilisateur

5. **Localisation** :
   - Ajouter support multilingue (Anglais, Espagnol, etc.)
   - Adapter les matières selon les régions

---

## �📞 Support et Maintenance

Pour toute modification :
1. Consulter ce fichier pour localiser le fichier concerné
2. Faire la modification
3. Tester avec `flutter run`
4. Vérifier les erreurs avec `flutter analyze`
5. Mettre à jour ce document si structure change

**Checklist de modification** :
- [ ] Modification effectuée
- [ ] Tests locaux réussis
- [ ] Pas d'erreurs de lint
- [ ] Documentation mise à jour
- [ ] Commit avec message clair

---

**Dernière mise à jour** : 23 Décembre 2025
**Version** : 2.0.0 (Stepper + Matières Dynamiques + Emojis Réactifs)
**Auteur** : ApprendChap Team

## 📖 Ressources Supplémentaires

- `README.md` : Documentation générale du projet
- `FEATURES.md` : Liste détaillée des fonctionnalités
- `PROJECT_STRUCTURE.md` : Ce fichier (Structure et guide de modification)
