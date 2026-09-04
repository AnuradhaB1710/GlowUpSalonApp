
import '../../domain/entities/salon_info_entity.dart';

abstract class SalonInfoRepository {
  Future<SalonInfoEntity> getSalonInfo();
}