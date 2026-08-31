import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/booking_model.dart';

/// Persists bookings on-device using `shared_preferences`, so they survive
/// app restarts and are only removed when the user explicitly cancels one.
/// Swapping this for `sqflite` or a remote API later means changing only
/// this file — the repository, use cases, providers, and UI stay untouched.
abstract class BookingLocalDataSource {
  Future<List<BookingModel>> getBookings();
  Future<void> addBooking(BookingModel booking);
  Future<void> cancelBooking(String bookingId);
}

class BookingLocalDataSourceImpl implements BookingLocalDataSource {
  static const _storageKey = 'salon_bookings';

  Future<List<BookingModel>> _readAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((item) => BookingModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _writeAll(List<BookingModel> bookings) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(bookings.map((b) => b.toJson()).toList());
    await prefs.setString(_storageKey, raw);
  }

  @override
  Future<List<BookingModel>> getBookings() => _readAll();

  @override
  Future<void> addBooking(BookingModel booking) async {
    final bookings = await _readAll();
    bookings.add(booking);
    await _writeAll(bookings);
  }

  @override
  Future<void> cancelBooking(String bookingId) async {
    final bookings = await _readAll();
    bookings.removeWhere((b) => b.id == bookingId);
    await _writeAll(bookings);
  }
}