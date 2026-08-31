import '../../../services/data/models/service_model.dart';
import '../../../services/data/models/stylist_model.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_datasource.dart';
import '../models/booking_model.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingLocalDataSource localDataSource;
  const BookingRepositoryImpl(this.localDataSource);

  @override
  Future<List<BookingEntity>> getBookings() => localDataSource.getBookings();

  @override
  Future<void> addBooking(BookingEntity booking) {
    // Wrap the plain entity into a model the data source can serialize.
    final model = BookingModel(
      id: booking.id,
      service: booking.service as ServiceModel,
      stylist: booking.stylist as StylistModel,
      dateTime: booking.dateTime,
      customerName: booking.customerName,
      phone: booking.phone,
    );
    return localDataSource.addBooking(model);
  }

  @override
  Future<void> cancelBooking(String bookingId) => localDataSource.cancelBooking(bookingId);
}
