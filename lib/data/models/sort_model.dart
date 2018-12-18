import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../classes/app/sort.dart';

class SortModel extends Model {
  static SortModel of(BuildContext context) =>
      ScopedModel.of<SortModel>(context);

  Sort _sort = Sort(
    defaultField: "",
    initialized: false,
    field: "",
    fields: [],
  );

  String get sortField => _sort?.field;
  List<String> get sortFields => _sort?.fields;

  bool get sortAscending => _sort?.ascending;

  set sortField(String value) {
    _sort?.field = value;
    notifyListeners();
  }

  sortASC() {
    _sort?.ascending = true;
    notifyListeners();
  }

  sortDESC() {
    _sort?.ascending = false;
    notifyListeners();
  }

  sortREVERSE() {
    final _isAsc = _sort?.ascending ?? false;
    _sort?.ascending = !_isAsc;
    notifyListeners();
  }

  set sortAscending(bool value) {
    _sort?.ascending = value;
    notifyListeners();
  }

  void setDefaults({String field, List<String> fields}) {
    _sort.field = field;
    _sort.fields = fields;
    notifyListeners();
  }

  bool get ready => _sort.initialized;

  void init() {
    _sort.initialized = true;
    notifyListeners();
  }
}
