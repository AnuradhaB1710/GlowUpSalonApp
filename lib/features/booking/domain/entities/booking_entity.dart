import '../../../services/domain/entities/service_entity.dart';
import '../../../services/domain/entities/stylist_entity.dart';

/// A booking links a service + stylist + time slot + customer.
/// It's fine for the booking feature's domain to depend on the services
/// feature's domain (entity-to-entity) — both are pure Dart. What it must
/// never depend on is the *data* or *presentation* layer of another feature.
class BookingEntity {
  final String id;
  final ServiceEntity service;
  final StylistEntity stylist;
  final DateTime dateTime;
  final String customerName;
  final String phone;

  const BookingEntity({
    required this.id,
    required this.service,
    required this.stylist,
    required this.dateTime,
    required this.customerName,
    required this.phone,
  });
}
