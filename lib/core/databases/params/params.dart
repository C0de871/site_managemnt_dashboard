abstract class Params {}

class NoParams extends Params {}

class NoBody {}

class TemplateParams extends Params {
  final int templateId;

  TemplateParams({required this.templateId});
}

class SearchGeneratorsWithPagination {
  final int page;
  final String searchQuery;

  static const String pageKey = 'page';
  static const String searchQueryKey = 'brand';

  SearchGeneratorsWithPagination({
    required this.page,
    required this.searchQuery,
  });

  Map<String, dynamic> toMap() {
    return {searchQueryKey: searchQuery, pageKey: page};
  }
}

class SearchPartsWithPagination {
  final int page;
  final String searchQuery;

  static const String pageKey = 'page';
  static const String searchQueryKey = 'code';

  SearchPartsWithPagination({required this.page, required this.searchQuery});

  Map<String, dynamic> toMap() {
    return {searchQueryKey: searchQuery, pageKey: page};
  }
}
