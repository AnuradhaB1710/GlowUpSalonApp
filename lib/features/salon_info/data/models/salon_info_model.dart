import '../../../salon_info/domain/entities/salon_info_entity.dart';

class SalonInfoModel extends SalonInfoEntity {
  const SalonInfoModel({
    required super.name,
    required super.address,
    required super.email,
  });

  factory SalonInfoModel.fromJson(Map<String, dynamic> json) => SalonInfoModel(
    name: json['name'] as String,
    address: json['address'] as String,
    email: json['email'] as String,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'email': email,
  };
}