
import '../models/salon_info_model.dart';

abstract class SalonInfoLocalDataSource {
  Future<SalonInfoModel> getSalonInfo();
}

class SalonInfoLocalDataSourceImpl implements SalonInfoLocalDataSource {
  @override
  Future<SalonInfoModel> getSalonInfo() async {
    await Future.delayed(const Duration(milliseconds: 150));
    return const SalonInfoModel(
      name: 'GlowUp Salon',
      address: '221 Maple Street, Suite 4, Springfield',
      email: 'hello@bloomsalon.example',
    );
  }
}