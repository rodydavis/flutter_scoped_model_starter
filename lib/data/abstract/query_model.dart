abstract class QueryModel {
  List _filtered;

  List get filtered => _filtered;

  String _searchValue;
  bool _isSearching;

  String get searchValue => _searchValue;
  bool get isSearching => _isSearching;

  void searchPressed() {}

  void searchChanged(String value) {}

  void filterResults() {}
}
