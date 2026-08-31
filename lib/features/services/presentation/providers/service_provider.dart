import 'package:flutter/foundation.dart';
import '../../domain/entities/service_entity.dart';
import '../../domain/entities/stylist_entity.dart';
import '../../domain/usecases/get_services.dart';
import '../../domain/usecases/get_stylists.dart';

enum LoadStatus { initial, loading, loaded, error }

/// Presentation-layer state holder. Pages only ever talk to this provider
/// (via `context.watch`/`context.read`) — never to a repository or data
/// source directly. It depends only on use cases, i.e. only on the domain.
class ServiceProvider extends ChangeNotifier {
  final GetServices _getServices;
  final GetStylists _getStylists;

  ServiceProvider({
    required GetServices getServices,
    required GetStylists getStylists,
  })  : _getServices = getServices,
        _getStylists = getStylists;

  LoadStatus status = LoadStatus.initial;
  String? errorMessage;

  List<ServiceEntity> _allServices = [];
  List<StylistEntity> stylists = [];

  String query = '';
  String category = 'All';

  List<String> get categories => [
        'All',
        ...{for (final s in _allServices) s.category},
      ];

  List<ServiceEntity> get filteredServices => _allServices.where((s) {
        final matchesCategory = category == 'All' || s.category == category;
        final matchesQuery = s.name.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesQuery;
      }).toList();

  Future<void> load() async {
    status = LoadStatus.loading;
    notifyListeners();
    try {
      _allServices = await _getServices();
      stylists = await _getStylists();
      status = LoadStatus.loaded;
    } catch (e) {
      status = LoadStatus.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    notifyListeners();
  }

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }
}
