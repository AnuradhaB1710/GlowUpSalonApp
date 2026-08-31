import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/icon_mapper.dart';
import '../providers/booking_provider.dart';

class BookingsListPage extends StatefulWidget {
  const BookingsListPage({super.key});

  @override
  State<BookingsListPage> createState() => _BookingsListPageState();
}

class _BookingsListPageState extends State<BookingsListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BookingProvider>().loadBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookingProvider>();
    final bookings = provider.bookings;

    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: bookings.isEmpty
          ? const Center(child: Text('No bookings yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: bookings.length,
              itemBuilder: (context, i) {
                final b = bookings[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      child: Icon(iconForKey(b.service.iconKey), color: AppColors.primary),
                    ),
                    title: Text(b.service.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text('with ${b.stylist.name}\n${DateFormat('EEE, MMM d • h:mm a').format(b.dateTime)}'),
                    isThreeLine: true,
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      onPressed: () => context.read<BookingProvider>().cancel(b.id),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
