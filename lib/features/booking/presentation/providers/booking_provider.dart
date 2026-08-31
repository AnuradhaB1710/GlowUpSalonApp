import 'package:flutter/foundation.dart';
import '../../domain/entities/booking_entity.dart';
import '../../domain/usecases/cancel_booking.dart';
import '../../domain/usecases/create_booking.dart';
import '../../domain/usecases/get_bookings.dart';

class BookingProvider extends ChangeNotifier {
  final GetBookings _getBookings;
  final CreateBooking _createBooking;
  final CancelBooking _cancelBooking;

  BookingProvider({
    required GetBookings getBookings,
    required CreateBooking createBooking,
    required CancelBooking cancelBooking,
  })  : _getBookings = getBookings,
        _createBooking = createBooking,
        _cancelBooking = cancelBooking;

  List<BookingEntity> bookings = [];
  bool isSubmitting = false;
  String? submitError;

  Future<void> loadBookings() async {
    bookings = await _getBookings();
    notifyListeners();
  }

  /// Returns true on success. On failure, `submitError` is populated and
  /// the caller (the page) can show it — the page never has to know *why*
  /// validation failed, just whether it did.
  Future<bool> submitBooking(BookingEntity booking) async {
    isSubmitting = true;
    submitError = null;
    notifyListeners();
    try {
      await _createBooking(booking);
      await loadBookings();
      isSubmitting = false;
      notifyListeners();
      return true;
    } catch (e) {
      isSubmitting = false;
      submitError = e is CreateBookingFailure ? e.message : 'Could not create booking.';
      notifyListeners();
      return false;
    }
  }

  Future<void> cancel(String bookingId) async {
    await _cancelBooking(bookingId);
    await loadBookings();
  }
}
