# ApprendChap - Nouvelles Fonctionnalités

## 📱 Pages d'Authentification Améliorées

### 1. Welcome Page (Page d'Accueil)
- Présentation de l'application
- Boutons "Commencer" et "Créer un compte"
- Images d'illustration

### 2. Login Page (Page de Connexion)
- **Switcher Email/Téléphone** : Les utilisateurs peuvent choisir entre se connecter avec leur email ou leur numéro de téléphone
- Validation des champs
- Lien "Mot de passe oublié"
- Boutons de connexion sociale (Google, Facebook)

### 3. Forgot Password Page (Réinitialisation du Mot de Passe)
- **Switcher Email/Téléphone** : Réinitialisation par email ou SMS
- Confirmation d'envoi avec interface de succès
- Option pour renvoyer le code

### 4. Account Type Selection (Sélection du Type de Compte)
Trois types de comptes disponibles :

#### a) **Compte Élève** (Indigo - #6366F1)
- Inscription avec nom, email, école, classe
- **Notation par Matière** : Évaluation sur 5 étoiles pour :
  - Français
  - Mathématiques
  - Anglais
  - Sciences
  - Histoire-Géographie
- **Code de Parrainage** : Optionnel pour les élèves parrainés
- Classes supportées : CP1-CP2, CE1-CE2, CM1-CM2, 6ème-Terminale (système Côte d'Ivoire)

#### b) **Compte Parent** (Violet - #8B5CF6)
- Inscription avec nom, email, téléphone
- Possibilité d'ajouter les enfants plus tard
- Suivi de la progression des enfants

#### c) **Compte Partenaire** (Ambre - #F59E0B)
- Inscription avec nom de l'entreprise, type d'activité
- Personne de contact
- **Système de Commission** : Commissions sur chaque abonnement vendu
- Types d'activité : École, Centre de formation, Organisme d'éducation, Influenceur, Blogueur, Autre

### 5. OTP Verification Page (Vérification OTP)
- **Système OTP Dual** : Support pour email et SMS
- 6 champs pour saisir le code OTP
- Compteur de renvoi (60 secondes)
- Bouton "Renvoyer le code" après expiration du délai

## 🎨 Composants Réutilisables

### CustomButton
- Bouton moderne avec état de chargement
- Couleurs personnalisables
- Animations fluides

### CustomTextField
- Champ texte avec validation
- Icônes préfixe/suffixe
- Toggle de visibilité pour les mots de passe
- Bordures colorées au focus

### ToggleInput
- Switcher Email/Téléphone
- Validation spécifique pour chaque type
- Interface intuitive

### StarRating
- Notation sur 5 étoiles
- Interaction tactile fluide
- Idéal pour l'évaluation des matières

### SocialButton
- Boutons pour réseaux sociaux
- Support des icônes SVG
- Design cohérent

## 🌐 Localisation

Tous les textes sont en français :
- Traductions complètes de l'interface
- Messages d'erreur en français
- Validation des champs en français

## 🔐 Sécurité

- Validation des emails et numéros de téléphone
- Validation des mots de passe (8+ caractères, majuscule, chiffre)
- Confirmation du mot de passe
- Acceptation des conditions d'utilisation obligatoire

## 📊 Structure des Données

### Élève
```
- Nom complet
- Email
- Mot de passe
- École
- Classe
- Notation par matière (1-5 étoiles)
- Code de parrainage (optionnel)
```

### Parent
```
- Nom
- Email
- Téléphone
- Mot de passe
- Enfants (à ajouter plus tard)
```

### Partenaire
```
- Nom de l'entreprise
- Type d'activité
- Personne de contact
- Email
- Téléphone
- Mot de passe
- Commission (%)
```

## 🎯 Flux de Navigation

```
Welcome Page
    ↓
Login Page ← → Forgot Password Page → OTP Verification
    ↓
Account Type Selection
    ├→ Signup Student Page → OTP Verification
    ├→ Signup Parent Page → OTP Verification
    └→ Signup Partner Page → OTP Verification
         ↓
      Home Page
```

## 📦 Dépendances

- `flutter_screenutil: ^5.9.3` - Responsive design
- `go_router: ^17.0.1` - Navigation
- `flutter_svg: ^2.0.0` - Support SVG

## 🚀 Prochaines Étapes

1. Intégration API pour l'authentification
2. Stockage sécurisé des données (SharedPreferences/Hive)
3. Implémentation du système OTP réel (Firebase/Twilio)
4. Dashboard pour chaque type de compte
5. Système de parrainage complet
6. Gestion des enfants pour les parents
7. Dashboard partenaire avec statistiques de commission
