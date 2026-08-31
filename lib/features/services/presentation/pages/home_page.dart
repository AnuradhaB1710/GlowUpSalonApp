import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../booking/presentation/pages/booking_page.dart';
import '../../../booking/presentation/pages/bookings_list_page.dart';
import '../providers/service_provider.dart';
import '../widgets/service_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // Kick off loading once, after first frame's provider is available.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bloom Salon', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.event_note_outlined),
            tooltip: 'My Bookings',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const BookingsListPage()),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<ServiceProvider>(
        builder: (context, provider, _) {
          if (provider.status == LoadStatus.loading || provider.status == LoadStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.status == LoadStatus.error) {
            return Center(child: Text('Something went wrong: ${provider.errorMessage}'));
          }
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: provider.setQuery,
                ),
              ),
              SizedBox(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, i) {
                    final cat = provider.categories[i];
                    final selected = cat == provider.category;
                    return ChoiceChip(
                      label: Text(cat),

                      selected: selected,
                      showCheckmark: false,
                      onSelected: (_) => provider.setCategory(cat),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      labelStyle: TextStyle(color: selected ? Colors.white : Colors.black87),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: selected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: provider.filteredServices.isEmpty
                    ? const Center(child: Text('No services found'))
                    : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  itemCount: provider.filteredServices.length,
                  itemBuilder: (context, i) {
                    final service = provider.filteredServices[i];
                    return ServiceCard(
                      service: service,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookingPage(service: service, stylists: provider.stylists),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}