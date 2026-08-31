import '../entities/stylist_entity.dart';
import '../repositories/service_repository.dart';

class GetStylists {
  final ServiceRepository repository;
  const GetStylists(this.repository);

  Future<List<StylistEntity>> call() => repository.getStylists();
}
