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

  List<CRUDObject> get items => _items;

  Future<bool> loadItems() async {
    // -- Load Items from API or Local --
    // _items = [
    //   CRUDObject(
    //     id: "43223444",
    //     name: "Test",
    //   ),
    //   CRUDObject(
    //     id: "4878746876",
    //     name: "Hello",
    //   ),
    //   CRUDObject(
    //     id: "928258625",
    //     name: "World",
    //   ),
    // ];
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

  void changeSortOrder(String field, bool ascending) {
    _items.sort((a, b) => a.compareTo(b, field, ascending));

    // if (ascending) _items = _items.reversed.toList();
    notifyListeners();
  }
}

class CRUDObject {
  final String id;

  // STARTER: fields - do not remove comment
  final String title;

  final String description;

  CRUDObject({@required this.id, this.title, this.description});

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
