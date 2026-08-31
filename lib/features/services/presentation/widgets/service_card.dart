import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/icon_mapper.dart';
import '../../domain/entities/service_entity.dart';

class ServiceCard extends StatelessWidget {
  final ServiceEntity service;
  final VoidCallback onTap;

  const ServiceCard({super.key, required this.service, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.primary.withOpacity(0.12),
          child: Icon(iconForKey(service.iconKey), color: AppColors.primary),
        ),
        title: Text(service.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('${service.durationMin} min • \$${service.price.toStringAsFixed(0)}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
