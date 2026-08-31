import '../entities/booking_entity.dart';

abstract class BookingRepository {
  Future<List<BookingEntity>> getBookings();
  Future<void> addBooking(BookingEntity booking);
  Future<void> cancelBooking(String bookingId);
}
