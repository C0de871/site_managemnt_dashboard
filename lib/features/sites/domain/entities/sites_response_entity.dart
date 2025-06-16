import 'package:equatable/equatable.dart';
import 'package:site_managemnt_dashboard/core/shared/domain/entities/pagination_entity.dart';
import 'package:site_managemnt_dashboard/features/sites/domain/entities/sites_entity.dart';

class SitesResponseEntity extends Equatable {
  final List<SiteEntity> sites;
  final PaginationEntity pagination;

  const SitesResponseEntity({required this.sites, required this.pagination});

  @override
  List<Object?> get props => [sites, pagination];

  //copy with:
  SitesResponseEntity copyWith({
    List<SiteEntity>? sites,
    PaginationEntity? pagination,
  }) {
    return SitesResponseEntity(
      sites: sites ?? this.sites,
      pagination: pagination ?? this.pagination,
    );
  }
}
