import '../repositories/booking_repository.dart';

class CancelBooking {
  final BookingRepository repository;
  const CancelBooking(this.repository);

  Future<void> call(String bookingId) => repository.cancelBooking(bookingId);
}
