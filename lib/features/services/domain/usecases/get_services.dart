import '../entities/service_entity.dart';
import '../repositories/service_repository.dart';

/// A use case wraps one specific business action. Providers/pages never
/// call the repository directly — they go through a use case, which keeps
/// business rules (validation, filtering, sorting, etc.) out of the UI.
class GetServices {
  final ServiceRepository repository;
  const GetServices(this.repository);

  Future<List<ServiceEntity>> call() => repository.getServices();
}
