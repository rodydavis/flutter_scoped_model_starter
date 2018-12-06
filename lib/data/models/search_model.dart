class SearchModel {
  final String search;
  final List<int> filters;

  SearchModel({this.filters, this.search});

  static SearchModel fromJson(Map<String, dynamic> json) {
    return SearchModel(
      search: json['search'],
      filters: json['filters'],
    );
  }

  Map<String, dynamic> toJson() => {
        'search': search,
        'filters': filters,
      };
}
