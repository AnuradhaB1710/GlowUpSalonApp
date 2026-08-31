import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

class GetBookings {
  final BookingRepository repository;
  const GetBookings(this.repository);

  Future<List<BookingEntity>> call() => repository.getBookings();
}
