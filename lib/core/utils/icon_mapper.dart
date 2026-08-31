import 'package:flutter/material.dart';

/// Domain entities store a plain [String] `iconKey` instead of a Flutter
/// [IconData] — the domain layer must stay framework-agnostic (no Flutter
/// imports). This mapper translates that key into an actual icon, and is
/// only ever used from the presentation layer.
IconData iconForKey(String key) {
  switch (key) {
    case 'cut':
      return Icons.content_cut;
    case 'color':
      return Icons.palette_outlined;
    case 'blowdry':
      return Icons.air;
    case 'manicure':
      return Icons.back_hand_outlined;
    case 'pedicure':
      return Icons.spa_outlined;
    case 'facial':
      return Icons.face_retouching_natural;
    case 'brows':
      return Icons.remove_red_eye_outlined;
    case 'massage':
      return Icons.self_improvement;
    default:
      return Icons.spa;
  }
}
