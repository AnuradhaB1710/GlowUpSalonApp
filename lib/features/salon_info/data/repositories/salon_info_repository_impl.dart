import '../../../salon_info/domain/entities/salon_info_entity.dart';
import '../../../salon_info/domain/repositories/salon_info_repository.dart';
import '../datasources/salon_info_local_data_source.dart';

class SalonInfoRepositoryImpl implements SalonInfoRepository {
  final SalonInfoLocalDataSource localDataSource;
  const SalonInfoRepositoryImpl(this.localDataSource);

  @override
  Future<SalonInfoEntity> getSalonInfo() => localDataSource.getSalonInfo();
}