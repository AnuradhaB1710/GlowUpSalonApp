import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class OfferBannerItem {
  final String title;
  final String subtitle;
  final String ctaLabel;

  const OfferBannerItem({
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
  });
}