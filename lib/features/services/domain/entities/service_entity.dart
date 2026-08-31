/// Domain entity: represents a salon service.
/// No Flutter/UI imports here on purpose — the domain layer is pure Dart
/// and knows nothing about how it will be displayed.
class ServiceEntity {
  final String id;
  final String name;
  final String category;
  final int durationMin;
  final double price;
  final String iconKey; // resolved to an actual icon in the presentation layer

  const ServiceEntity({
    required this.id,
    required this.name,
    required this.category,
    required this.durationMin,
    required this.price,
    required this.iconKey,
  });
}
