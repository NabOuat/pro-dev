# 🏗️ Architecture du Projet Flutter

Ce projet Flutter suit une **Clean Architecture par fonctionnalité (feature-based)**.  
L'objectif est d'avoir une application **scalable, maintenable, testable et professionnelle**.

---

## 🎯 Principes Clés

- ✅ Séparation claire des responsabilités
- ✅ Indépendance de l'UI par rapport à la logique métier
- ✅ Backend logique isolé (API, Firebase, DB)
- ✅ Architecture adaptée aux projets de taille moyenne à grande
- ✅ Facile à faire évoluer et à tester

---

## 📁 Structure Générale

```
lib/
├── core/                 # Fondations globales
├── features/             # Fonctionnalités isolées
├── shared/               # Composants réutilisables
├── routes/               # Navigation centralisée
├── injection.dart        # Dependency Injection
└── main.dart             # Point d'entrée
```

---

## 🔹 `core/` – Fondations de l'application

Contient tout ce qui est **global et réutilisable** dans toute l'application.

```
core/
├── config/               # Configuration app (env, flavors)
├── constants/            # Constantes globales
├── errors/               # Gestion des erreurs
├── network/              # Client HTTP (Dio, API)
├── theme/                # Thème, couleurs, styles
└── utils/                # Helpers et fonctions utilitaires
```

**⚠️ Règle importante :** Aucun code spécifique à une fonctionnalité ne doit se trouver ici.

---

## 🔹 `features/` – Architecture par fonctionnalité

Chaque fonctionnalité (auth, home, profile, etc.) est **totalement isolée** et autonome.

### Structure d'une Feature

```
features/[feature_name]/
├── data/                 # Sources de données
├── domain/               # Logique métier
└── presentation/         # Interface utilisateur
```

**Exemple :** `features/auth/`

---

### 📌 `data/` – Backend logique

Contient tout ce qui concerne les **sources de données**.

```
data/
├── datasources/          # API, Firebase, Local storage
│   ├── remote_datasource.dart
│   └── local_datasource.dart
├── models/               # Models / DTO
│   └── user_model.dart
└── repositories/         # Implémentations des repositories
    └── user_repository_impl.dart
```

**Responsabilités :**
- Appels API (Dio, HTTP)
- Firebase Firestore / Realtime Database
- SQLite / SharedPreferences
- Mapping JSON ↔ Dart objects

---

### 📌 `domain/` – Logique métier

Cœur de l'application, **indépendant de Flutter et des frameworks externes**.

```
domain/
├── entities/             # Objets métier purs
│   └── user.dart
├── repositories/         # Interfaces (contrats)
│   └── user_repository.dart
└── usecases/             # Cas d'utilisation
    └── get_user_usecase.dart
```

**Règle d'or :** Aucune dépendance à l'UI, Flutter ou packages externes.

---

### 📌 `presentation/` – Frontend (UI)

Tout ce qui est visible par l'utilisateur.

```
presentation/
├── pages/                # Écrans complets
│   └── user_page.dart
├── widgets/              # Widgets spécifiques à la feature
│   └── user_card.dart
└── state/                # State management (Bloc, Provider, Riverpod)
    └── user_bloc.dart
```

**Contient :**
- Pages Flutter
- Gestion d'état (Bloc, Provider, Riverpod)
- Interaction utilisateur
- Widgets spécifiques à la feature

---

## 🔹 `shared/` – Éléments réutilisables

Code partagé entre **plusieurs fonctionnalités**.

```
shared/
├── widgets/              # Widgets communs (boutons, dialogs, etc.)
│   ├── custom_button.dart
│   └── custom_dialog.dart
└── layouts/              # Layouts génériques
    └── app_layout.dart
```

**À utiliser pour :** Composants UI génériques, helpers partagés.

---

## 🔹 `routes/` – Navigation centralisée

```
routes/
└── app_router.dart       # Configuration des routes
```

**Avantages :**
- Centralisation des routes
- Navigation propre et maîtrisée
- Facilite la maintenance

---

## 🔹 `injection.dart` – Dependency Injection

Fichier dédié à l'enregistrement des dépendances.

**Responsabilités :**
- Enregistrement des services
- Gestion des dépendances
- Facilite les tests unitaires
- Améliore la modularité

---

## 🔹 `main.dart` – Point d'entrée

```dart
void main() {
  // 1. Initialisation
  // 2. Injection des dépendances
  // 3. Lancement de l'app
  runApp(const MyApp());
}
```

---

## ✅ Avantages de cette Architecture

| Avantage | Bénéfice |
|----------|----------|
| **Scalabilité** | Ajouter des features sans affecter le code existant |
| **Testabilité** | Chaque couche peut être testée indépendamment |
| **Lisibilité** | Code organisé et facile à naviguer |
| **Collaboration** | Équipes peuvent travailler sur des features en parallèle |
| **Maintenabilité** | Modifications localisées et prévisibles |
| **Production-ready** | Adaptée aux projets professionnels |

---

## 🚀 Bonnes Pratiques

1. **Une feature = un dossier** → Isolation complète
2. **Pas de logique métier dans l'UI** → Utiliser les usecases
3. **Pas d'appel API direct depuis les pages** → Passer par les repositories
4. **Tester les `usecases` et `repositories`** → Couverture de tests
5. **Respecter les dépendances** → Domain → Data, Presentation → Domain
6. **Nommer clairement** → `user_repository.dart`, `get_user_usecase.dart`

---

## 📌 Évolutions Possibles

- 🔥 Intégration Firebase (Firestore, Auth)
- 🧪 Tests unitaires et widget tests
- 🌐 Support Web / Desktop
- 📦 Modularisation avancée (packages séparés)
- 🔐 Gestion sécurisée des tokens (Secure Storage)
- 📊 Analytics et Crashlytics

---

## 📚 Ressources & Patterns

- **State Management :** Bloc, Provider, Riverpod
- **HTTP Client :** Dio, HTTP
- **Local Storage :** SharedPreferences, SQLite, Hive
- **Dependency Injection :** GetIt, Riverpod

---

💡 **Note :** Cette architecture est inspirée de la **Clean Architecture** de Robert C. Martin et adaptée à Flutter pour un usage en production.
