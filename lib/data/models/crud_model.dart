import 'package:scoped_model/scoped_model.dart';

class CRUDFields {
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

  void changeSortOrder(
    String field,
    bool ascending,
  ) {
    // STARTER: sort - do not remove comment
    if (field == CRUDFields.title) {
      _items.sort((a, b) => a.name.compareTo(b.name));
    }
    if (field == CRUDFields.description) {
      _items.sort((a, b) => a.description.compareTo(b.description));
    }

    if (ascending) _items = _items.reversed.toList();
    notifyListeners();
  }
}

class CRUDObject {
  final String id, name, description;

  CRUDObject({this.id, this.name, this.description});

  @override
  String toString() {
    var _result = name.toString();
    return _result.toString();
  }
}
