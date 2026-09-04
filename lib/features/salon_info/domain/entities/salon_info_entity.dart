/// Domain entity: minimal salon information — just what's needed to
/// identify and contact the salon. Pure Dart, no Flutter imports.
class SalonInfoEntity {
  final String name;
  final String address;
  final String email;

  const SalonInfoEntity({
    required this.name,
    required this.address,
    required this.email,
  });
}