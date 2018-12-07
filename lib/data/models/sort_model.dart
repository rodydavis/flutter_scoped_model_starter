import 'package:scoped_model/scoped_model.dart';

class SortModel extends Model {
  final String defaultSortField;
  List<String> sortFields;
  SortModel({this.sortFields, this.defaultSortField});

  bool _sortAscending = false;
  String _sortField = "";

  String get sortField => _sortField;
  bool get sortAscending => _sortAscending;

  set sortField(String value) {
    _sortField = value;
    notifyListeners();
  }

  sortASC() {
    _sortAscending = true;
    notifyListeners();
  }

  sortDESC() {
    _sortAscending = false;
    notifyListeners();
  }

  sortREVERSE() {
    _sortAscending = !_sortAscending;
    notifyListeners();
  }

  set sortAscending(bool value) {
    _sortAscending = value;
    notifyListeners();
  }
}
