import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/salon_info_provider.dart';

class SalonInfoPage extends StatefulWidget {
  const SalonInfoPage({super.key});

  @override
  State<SalonInfoPage> createState() => _SalonInfoPageState();
}

class _SalonInfoPageState extends State<SalonInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SalonInfoProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Salon Info')),
      body: Consumer<SalonInfoProvider>(
        builder: (context, provider, _) {
          if (provider.status == LoadStatus.loading || provider.status == LoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.status == LoadStatus.error || provider.info == null) {
            return Center(child: Text('Could not load salon info: ${provider.errorMessage ?? ''}'));
          }

          final info = provider.info!;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Card(
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      child: const Icon(Icons.spa, color: AppColors.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(info.name,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    _InfoRow(icon: Icons.location_on_outlined, label: info.address),
                    const SizedBox(height: 12),
                    _InfoRow(icon: Icons.email_outlined, label: info.email),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14, height: 1.4))),
      ],
    );
  }
}