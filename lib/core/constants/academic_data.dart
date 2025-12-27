// Données académiques pour les élèves

class AcademicData {
  // Toutes les classes disponibles
  static const List<String> allGrades = [
    'CP1', 'CP2', 'CE1', 'CE2', 'CM1', 'CM2', // Primaire
    '6ème', '5ème', '4ème', '3ème', // Collège
    '2nde', '1ère', 'Terminale', // Lycée
    'BTS', // Supérieur
  ];

  // Séries par classe (pour lycée uniquement)
  static const Map<String, List<String>> seriesByGrade = {
    '2nde': ['Générale'],
    '1ère': ['A1', 'A2', 'C', 'D', 'TI'],
    'Terminale': ['A1', 'A2', 'C', 'D', 'TI'],
  };

  // Matières principales par série
  static const Map<String, List<String>> subjectsBySerie = {
    'Générale': ['Français', 'Mathématiques', 'Anglais', 'Sciences', 'Histoire-Géographie'],
    'A1': ['Français', 'Philosophie', 'Histoire-Géographie', 'Anglais', 'Littérature'],
    'A2': ['Français', 'Philosophie', 'Histoire-Géographie', 'Anglais', 'Littérature'],
    'C': ['Mathématiques', 'Physique-Chimie', 'Sciences de la Vie', 'Anglais', 'Français'],
    'D': ['Mathématiques', 'Physique-Chimie', 'Sciences de la Vie', 'Anglais', 'Français'],
    'TI': ['Mathématiques', 'Informatique', 'Électronique', 'Anglais', 'Français'],
  };

  // Matières pour les classes primaires et collège
  static const Map<String, List<String>> subjectsByGrade = {
    'CP1': ['Français', 'Mathématiques', 'Sciences', 'Éducation Physique', 'Arts Plastiques'],
    'CP2': ['Français', 'Mathématiques', 'Sciences', 'Éducation Physique', 'Arts Plastiques'],
    'CE1': ['Français', 'Mathématiques', 'Sciences', 'Éducation Physique', 'Arts Plastiques'],
    'CE2': ['Français', 'Mathématiques', 'Sciences', 'Éducation Physique', 'Arts Plastiques'],
    'CM1': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Éducation Physique'],
    'CM2': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Éducation Physique'],
    '6ème': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Anglais'],
    '5ème': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Anglais'],
    '4ème': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Anglais'],
    '3ème': ['Français', 'Mathématiques', 'Sciences', 'Histoire-Géographie', 'Anglais'],
  };

  // Filières BTS
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
  ];

  // Années BTS
  static const List<String> btsYears = [
    '1ère année',
    '2ème année',
  ];

  // Matières par filière BTS
  static const Map<String, List<String>> subjectsByBtsFiliere = {
    'Informatique': ['Programmation', 'Bases de Données', 'Réseaux', 'Cybersécurité'],
    'Électronique': ['Électronique Analogique', 'Électronique Numérique', 'Automatisme', 'Microcontrôleurs'],
    'Mécanique': ['Mécanique Générale', 'Résistance des Matériaux', 'CAO', 'Fabrication'],
    'Gestion': ['Comptabilité', 'Finance', 'Management', 'Marketing'],
    'Comptabilité': ['Comptabilité Générale', 'Comptabilité Analytique', 'Fiscalité', 'Audit'],
    'Commerce': ['Vente', 'Marketing', 'Négociation', 'Gestion Commerciale'],
    'Tourisme': ['Géographie Touristique', 'Gestion Hôtelière', 'Langues', 'Patrimoine'],
    'Hôtellerie': ['Cuisine', 'Service', 'Gestion Hôtelière', 'Hygiène'],
    'Santé': ['Biologie', 'Chimie', 'Anatomie', 'Physiologie'],
    'Autre': ['Matière 1', 'Matière 2', 'Matière 3', 'Matière 4'],
  };

  // Types d'activité pour les partenaires
  static const List<String> businessTypes = [
    'École',
    'Centre de formation',
    'Organisme d\'éducation',
    'Influenceur',
    'Blogueur',
    'Autre',
  ];
}

// Données pour les emojis et couleurs selon le niveau
class RatingData {
  static const Map<int, Map<String, dynamic>> ratingInfo = {
    1: {
      'emoji': '😢',
      'color': 0xFFEF4444, // Rouge
      'label': 'Très faible',
    },
    2: {
      'emoji': '😕',
      'color': 0xFFF59E0B, // Ambre
      'label': 'Faible',
    },
    3: {
      'emoji': '😐',
      'color': 0xFFFBBF24, // Jaune
      'label': 'Moyen',
    },
    4: {
      'emoji': '😊',
      'color': 0xFF10B981, // Vert
      'label': 'Bon',
    },
    5: {
      'emoji': '🤩',
      'color': 0xFF6366F1, // Indigo
      'label': 'Excellent',
    },
  };
}
