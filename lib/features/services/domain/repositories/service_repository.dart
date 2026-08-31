import '../entities/service_entity.dart';
import '../entities/stylist_entity.dart';

/// Contract the domain layer depends on. The data layer provides the
/// concrete implementation, so the direction of dependency points
/// *inward* toward the domain — the core rule of Clean Architecture.
abstract class ServiceRepository {
  Future<List<ServiceEntity>> getServices();
  Future<List<StylistEntity>> getStylists();
}
