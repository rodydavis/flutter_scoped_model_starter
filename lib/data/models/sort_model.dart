import 'package:scoped_model/scoped_model.dart';

class SortModel extends Model {
  bool _sortAscending = false;
  String _sortField = "";
  List<String> _sortFields = [];

  String get sortField => _sortField;
  bool get sortAscending => _sortAscending;
  List<String> get sortFields => _sortFields;

  set sortField(String value) {
    _sortField = value;
    notifyListeners();
  }

  set sortFields(List<String> values) {
    _sortFields = values;
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
