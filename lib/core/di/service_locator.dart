import 'package:get_it/get_it.dart';

import '../../features/booking/data/datasources/booking_local_datasource.dart';
import '../../features/booking/data/repositories/booking_repository_impl.dart';
import '../../features/booking/domain/repositories/booking_repository.dart';
import '../../features/booking/domain/usecases/cancel_booking.dart';
import '../../features/booking/domain/usecases/create_booking.dart';
import '../../features/booking/domain/usecases/get_bookings.dart';
import '../../features/booking/presentation/providers/booking_provider.dart';

import '../../features/services/data/datasources/service_local_datasource.dart';
import '../../features/services/data/repositories/service_repository_impl.dart';
import '../../features/services/domain/repositories/service_repository.dart';
import '../../features/services/domain/usecases/get_services.dart';
import '../../features/services/domain/usecases/get_stylists.dart';
import '../../features/services/presentation/providers/service_provider.dart';


import '../../features/salon_info/data/datasources/salon_info_local_data_source.dart';
import '../../features/salon_info/data/repositories/salon_info_repository_impl.dart';
import '../../features/salon_info/domain/repositories/salon_info_repository.dart';
import '../../features/salon_info/domain/usecases/get_salon_info.dart';
import '../../features/salon_info/presentation/providers/salon_info_provider.dart';

final sl = GetIt.instance;

/// Registers every dependency, from the outside in:
/// data sources -> repositories -> use cases -> providers.
/// Call once, at app startup, before `runApp`.
void setupServiceLocator() {
  // ----- Services feature -----
  sl.registerLazySingleton<ServiceLocalDataSource>(() => ServiceLocalDataSourceImpl());
  sl.registerLazySingleton<ServiceRepository>(() => ServiceRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetServices(sl()));
  sl.registerLazySingleton(() => GetStylists(sl()));
  sl.registerFactory(() => ServiceProvider(getServices: sl(), getStylists: sl()));

  // ----- Booking feature -----
  sl.registerLazySingleton<BookingLocalDataSource>(() => BookingLocalDataSourceImpl());
  sl.registerLazySingleton<BookingRepository>(() => BookingRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetBookings(sl()));
  sl.registerLazySingleton(() => CreateBooking(sl()));
  sl.registerLazySingleton(() => CancelBooking(sl()));
  sl.registerFactory(() => BookingProvider(getBookings: sl(), createBooking: sl(), cancelBooking: sl()));

  // ----- Salon Info feature -----
  sl.registerLazySingleton<SalonInfoLocalDataSource>(() => SalonInfoLocalDataSourceImpl());
  sl.registerLazySingleton<SalonInfoRepository>(() => SalonInfoRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetSalonInfo(sl()));
  sl.registerFactory(() => SalonInfoProvider(getSalonInfo: sl()));
}
