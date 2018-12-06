import 'package:scoped_model/scoped_model.dart';

class CRUDModel extends Model {
  List<CRUDObject> _items = [];

  List<CRUDObject> get items => _items;

  Future<bool> loadItems() async {
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
}

class CRUDObject {
  final String id, name;

  CRUDObject({this.id, this.name});

  @override
  String toString() {
    var _result = name.toString();
    return _result.toString();
  }
}
