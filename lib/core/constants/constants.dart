export 'app_colors.dart';

class AppConstants {
  static const String appName = 'ApprendChap';
  static const String appVersion = '1.0.0';
  
  static const double defaultPadding = 24.0;
  static const double defaultBorderRadius = 12.0;
  
  static const Duration animationDuration = Duration(milliseconds: 300);
  
  // Grades (Côte d'Ivoire)
  static const List<String> grades = [
    'CP1', 'CP2', 'CE1', 'CE2', 'CM1', 'CM2',
    '6ème', '5ème', '4ème', '3ème',
    '2nde', '1ère', 'Terminale'
  ];
  
  // Main subjects
  static const List<String> mainSubjects = [
    'Français',
    'Mathématiques',
    'Anglais',
    'Sciences',
    'Histoire-Géographie'
  ];
  
  // Business types for partners
  static const List<String> businessTypes = [
    'École',
    'Centre de formation',
    'Organisme d\'éducation',
    'Influenceur',
    'Blogueur',
    'Autre'
  ];
}
