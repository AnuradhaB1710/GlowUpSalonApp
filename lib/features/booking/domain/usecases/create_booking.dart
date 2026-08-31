import '../entities/booking_entity.dart';
import '../repositories/booking_repository.dart';

/// Business rule lives here, not in the UI: a booking cannot be created
/// for a time in the past. Any future rule (e.g. "stylist already booked
/// at this time") belongs in this use case too.
class CreateBookingFailure implements Exception {
  final String message;
  const CreateBookingFailure(this.message);
  @override
  String toString() => message;
}

class CreateBooking {
  final BookingRepository repository;
  const CreateBooking(this.repository);

  Future<void> call(BookingEntity booking) async {
    if (booking.dateTime.isBefore(DateTime.now())) {
      throw const CreateBookingFailure('Cannot book an appointment in the past.');
    }
    if (booking.customerName.trim().isEmpty) {
      throw const CreateBookingFailure('Customer name is required.');
    }
    await repository.addBooking(booking);
  }
}
