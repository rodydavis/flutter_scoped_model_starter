import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/foundation.dart';

class CRUDFields {
  static const String id = 'ID';

  // STARTER: fields - do not remove comment
  static const String title = 'Title';

  static const String description = 'Description';
}

class CRUDModel extends Model {
  List<CRUDObject> _items = [];
  List<CRUDObject> _filtered = [];

  List<CRUDObject> get items => _items;
  List<CRUDObject> get filteredItems => _filtered;

  Future<bool> loadItems() async {
    // -- Load Items from API or Local --
    notifyListeners();
    return true;
  }

  void addItem(CRUDObject item) {
    print("Adding Item => ${item?.id}");
    _items.add(item);
    notifyListeners();
  }

  void removeItem(CRUDObject item) {
    print("Removing Item => ${item?.id}");
    _items.remove(item);
    notifyListeners();
  }

  void editItem(CRUDObject item) {
    print("Editing Item => ${item?.id}");
    if (items.isNotEmpty)
      for (var _item in items) {
        if (_item.id == item.id) {
          _items.remove(_item);
          _items.add(item);
        }
      }
    notifyListeners();
  }

  void sort(String field, bool ascending) {
    _items.sort((a, b) => a.compareTo(b, field, ascending));
    notifyListeners();
  }

  void search(String value) {
    print("Searching... $value");

    List<CRUDObject> _results = [];

    for (var _item in items) {
      if (_item.matchesSearch(value)) {
        _results.add(_item);
      }
    }

    _filtered = _results;
    notifyListeners();
  }

  void startSearching() {
    _filtered = _items;
    notifyListeners();
  }

  void stopSearching() {
    loadItems();
    notifyListeners();
  }

  Future loadDummyData() async {
    var _list = [
      CRUDObject(id: "98730894093847037", title: "Test", description: ""),
      CRUDObject(
          id: "n0c892n97c23",
          title: "Hello",
          description: "Haha that was funny"),
      CRUDObject(id: "h028c090hhc07897h2", title: "World", description: ""),
      CRUDObject(id: "9487474937383", title: "Johhny", description: "???"),
      CRUDObject(id: "c0289ncn2bccc", title: "Appleseed", description: ""),
      CRUDObject(id: "837692837962", title: "Jobs", description: ""),
      CRUDObject(id: "4020937809837", title: "Steve", description: ":-)"),
    ];
    _items = _list;
    notifyListeners();
  }
}

class CRUDObject {
  final String id;

  // STARTER: object - do not remove comment
  final String title;

  final String description;

  CRUDObject({
    @required this.id,
    this.title,
    this.description,
  });

  int compareTo(CRUDObject object, String sortField, bool sortAscending) {
    int response = 0;
    CRUDObject contactA = sortAscending ? this : object;
    CRUDObject contactB = sortAscending ? object : this;

    switch (sortField) {
      // STARTER: sort switch - do not remove comment
      case CRUDFields.title:
        response = contactA.title.compareTo(contactB.title);
        break;

      case CRUDFields.description:
        response = contactA.description.compareTo(contactB.description);
        break;
    }

    if (response == 0) {
      // STARTER: sort default - do not remove comment
      return contactA.title.compareTo(contactB.title);
    } else {
      return response;
    }
  }

  bool matchesSearch(String search) {
    if (search == null || search.isEmpty) {
      return true;
    }

    search = search.toLowerCase();

    // STARTER: search - do not remove comment
    if (title.toLowerCase().contains(search)) {
      return true;
    }

    if (description.toLowerCase().contains(search)) {
      return true;
    }

    return false;
  }

  @override
  String toString() {
    var _result = title.toString();
    return _result.toString();
  }
}
