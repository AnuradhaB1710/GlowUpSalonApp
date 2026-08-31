import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'features/booking/presentation/providers/booking_provider.dart';
import 'features/services/presentation/pages/home_page.dart';
import 'features/services/presentation/providers/service_provider.dart';

void main() {
  setupServiceLocator();
  runApp(const SalonApp());
}

class SalonApp extends StatelessWidget {
  const SalonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // Providers are created via the service locator, so they receive
      // their use cases fully wired — main.dart doesn't know or care
      // about repositories or data sources.
      providers: [
        ChangeNotifierProvider<ServiceProvider>(create: (_) => sl<ServiceProvider>()),
        ChangeNotifierProvider<BookingProvider>(create: (_) => sl<BookingProvider>()),
      ],

      child: MaterialApp(
        title: 'Bloom Salon',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const HomePage(),
      ),
    );
  }
}
