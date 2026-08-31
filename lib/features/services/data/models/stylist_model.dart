import '../../domain/entities/stylist_entity.dart';

class StylistModel extends StylistEntity {
  const StylistModel({
    required super.id,
    required super.name,
    required super.specialty,
  });

  factory StylistModel.fromJson(Map<String, dynamic> json) => StylistModel(
        id: json['id'] as String,
        name: json['name'] as String,
        specialty: json['specialty'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'specialty': specialty,
      };
}
