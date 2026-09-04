import 'package:flutter/foundation.dart';
import '../../domain/entities/salon_info_entity.dart';

import '../../domain/usecases/get_salon_info.dart';

enum LoadStatus { initial, loading, loaded, error }

class SalonInfoProvider extends ChangeNotifier {
  final GetSalonInfo _getSalonInfo;
  SalonInfoProvider({required GetSalonInfo getSalonInfo}) : _getSalonInfo = getSalonInfo;

  LoadStatus status = LoadStatus.initial;
  String? errorMessage;
  SalonInfoEntity? info;

  Future<void> load() async {
    status = LoadStatus.loading;
    notifyListeners();
    try {
      info = await _getSalonInfo();
      status = LoadStatus.loaded;
    } catch (e) {
      status = LoadStatus.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}