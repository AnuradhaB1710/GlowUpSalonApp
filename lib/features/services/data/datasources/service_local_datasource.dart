import '../models/service_model.dart';
import '../models/stylist_model.dart';

/// Data source: the *only* place that knows where the raw data comes from.
/// Today it's an in-memory list; swap this file's contents for an HTTP
/// client (`ServiceRemoteDataSource`) or a `sqflite`/`hive` box later
/// without touching the repository, use cases, or UI.
abstract class ServiceLocalDataSource {
  Future<List<ServiceModel>> getServices();
  Future<List<StylistModel>> getStylists();
}

class ServiceLocalDataSourceImpl implements ServiceLocalDataSource {
  static final List<ServiceModel> _services = [
    const ServiceModel(id: 's1', name: "Women's Haircut", category: 'Hair', durationMin: 45, price: 35, iconKey: 'cut'),
    const ServiceModel(id: 's2', name: "Men's Haircut", category: 'Hair', durationMin: 30, price: 25, iconKey: 'cut'),
    const ServiceModel(id: 's3', name: 'Hair Coloring', category: 'Hair', durationMin: 90, price: 80, iconKey: 'color'),
    const ServiceModel(id: 's4', name: 'Blow Dry & Style', category: 'Hair', durationMin: 40, price: 30, iconKey: 'blowdry'),
    const ServiceModel(id: 's5', name: 'Classic Manicure', category: 'Nails', durationMin: 30, price: 20, iconKey: 'manicure'),
    const ServiceModel(id: 's6', name: 'Gel Pedicure', category: 'Nails', durationMin: 45, price: 35, iconKey: 'pedicure'),
    const ServiceModel(id: 's7', name: 'Classic Facial', category: 'Skin', durationMin: 60, price: 55, iconKey: 'facial'),
    const ServiceModel(id: 's8', name: 'Eyebrow Threading', category: 'Skin', durationMin: 15, price: 12, iconKey: 'brows'),
    const ServiceModel(id: 's9', name: 'Relaxing Massage', category: 'Spa', durationMin: 60, price: 65, iconKey: 'massage'),
  ];

  static final List<StylistModel> _stylists = [
    const StylistModel(id: 'st1', name: 'Ava Reyes', specialty: 'Hair & Color Specialist'),
    const StylistModel(id: 'st2', name: 'Liam Chen', specialty: 'Barber'),
    const StylistModel(id: 'st3', name: 'Priya Nair', specialty: 'Nail Artist'),
    const StylistModel(id: 'st4', name: 'Sofia Rossi', specialty: 'Esthetician'),
  ];

  @override
  Future<List<ServiceModel>> getServices() async {
    // Simulated latency so the UI's loading state is exercised even locally.
    await Future.delayed(const Duration(milliseconds: 200));
    return _services;
  }

  @override
  Future<List<StylistModel>> getStylists() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _stylists;
  }
}
