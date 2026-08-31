import '../../../services/data/models/service_model.dart';
import '../../../services/data/models/stylist_model.dart';
import '../../domain/entities/booking_entity.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required ServiceModel super.service,
    required StylistModel super.stylist,
    required super.dateTime,
    required super.customerName,
    required super.phone,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        service: ServiceModel.fromJson(json['service'] as Map<String, dynamic>),
        stylist: StylistModel.fromJson(json['stylist'] as Map<String, dynamic>),
        dateTime: DateTime.parse(json['dateTime'] as String),
        customerName: json['customerName'] as String,
        phone: json['phone'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'service': (service as ServiceModel).toJson(),
        'stylist': (stylist as StylistModel).toJson(),
        'dateTime': dateTime.toIso8601String(),
        'customerName': customerName,
        'phone': phone,
      };
}
