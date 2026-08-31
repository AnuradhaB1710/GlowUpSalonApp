import '../../domain/entities/service_entity.dart';
import '../../domain/entities/stylist_entity.dart';
import '../../domain/repositories/service_repository.dart';
import '../datasources/service_local_datasource.dart';

/// Implements the domain's [ServiceRepository] contract using a data source.
/// This is the piece that makes the dependency arrow point inward: domain
/// defines the interface, data implements it — domain never imports data.
class ServiceRepositoryImpl implements ServiceRepository {
  final ServiceLocalDataSource localDataSource;
  const ServiceRepositoryImpl(this.localDataSource);

  @override
  Future<List<ServiceEntity>> getServices() => localDataSource.getServices();

  @override
  Future<List<StylistEntity>> getStylists() => localDataSource.getStylists();
}
