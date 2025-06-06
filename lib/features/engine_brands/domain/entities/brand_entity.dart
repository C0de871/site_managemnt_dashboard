import 'package:equatable/equatable.dart';

class BrandEntity extends Equatable {
  final int id;
  final String brand;

  const BrandEntity({required this.id, required this.brand});

  @override
  List<Object?> get props => [id, brand];

  BrandEntity copyWith({int? id, String? brand}) {
    return BrandEntity(id: id ?? this.id, brand: brand ?? this.brand);
  }
}
