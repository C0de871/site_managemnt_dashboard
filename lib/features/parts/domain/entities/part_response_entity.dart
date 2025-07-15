import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/parts/domain/entities/part_entity.dart';

class PartResponseEntity extends Equatable {
  final List<PartEntity> parts;
  final PaginationEntity? pagination; //todo: remove the null in the future

  const PartResponseEntity({required this.parts, this.pagination});

  @override
  List<Object?> get props => [parts, pagination];

  //!copywith
  PartResponseEntity copyWith({
    List<PartEntity>? parts,
    PaginationEntity? pagination,
  }) {
    return PartResponseEntity(
      parts: parts ?? this.parts,
      pagination: pagination ?? this.pagination,
    );
  }
}
