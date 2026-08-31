import '../../domain/entities/service_entity.dart';

/// Data-layer model. It "is a" [ServiceEntity] (via extends) plus the
/// serialization concerns (fromJson/toJson) that the domain layer must
/// never know about. If you later fetch this from an API or a local
/// database, only this file and the data source need to change.
class ServiceModel extends ServiceEntity {
  const ServiceModel({
    required super.id,
    required super.name,
    required super.category,
    required super.durationMin,
    required super.price,
    required super.iconKey,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        durationMin: json['durationMin'] as int,
        price: (json['price'] as num).toDouble(),
        iconKey: json['iconKey'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'durationMin': durationMin,
        'price': price,
        'iconKey': iconKey,
      };
}
