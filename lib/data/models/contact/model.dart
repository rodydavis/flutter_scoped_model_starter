import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../constants.dart';
import '../../models/auth/model.dart';
import '../../models/paging_model.dart';
import '../../repositories/contact_repository.dart';
import 'list.dart';

class ContactModel extends Model {
  // -- Paging --
  PagingModel _paging = PagingModel(rows: 100, page: 1);

  void nextPage(BuildContext context) {
    _paging = PagingModel(
      rows: _paging.rows,
      page: _paging.page + 1,
    );
    loadItems(context);
    notifyListeners();
  }

  void refresh(BuildContext context) {
    _paging = PagingModel(
      rows: _paging.rows,
      page: _paging.page,
    );
    loadItems(context);
    notifyListeners();
  }

  bool _loaded = false;
  int _lastUpdated = 0;

  List<ContactObject> _items = [];
  List<ContactObject> _filtered = [];

  int get lastUpdated => _lastUpdated;

  bool get isLoaded {
    if (isStale) return false;
    return _loaded;
  }

  bool get isStale {
    // if (!isLoaded) return true;
    if (lastUpdated == 0) return true;
    try {
      return DateTime.now().millisecondsSinceEpoch - lastUpdated >
          kMillisecondsToRefreshData;
    } catch (e) {
      print(e);
      return true;
    }
    // return false;
  }

  set loaded(bool value) {
    _loaded = true;
    notifyListeners();
  }

  List<ContactObject> get items => _items;
  List<ContactObject> get filteredItems => _filtered;

  Future<bool> loadItems(BuildContext context) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    // -- Load Items from API or Local --
    var _contacts = await ContactRepository().loadList(_auth, paging: _paging);
    _items = _contacts?.result;
    _lastUpdated = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
    return true;
  }

  void addItem(ContactObject item) {
    print("Adding Item => ${item?.id}");
    _items.add(item);
    notifyListeners();
  }

  void removeItem(ContactObject item) {
    print("Removing Item => ${item?.id}");
    _items.remove(item);
    notifyListeners();
  }

  void editItem(ContactObject item) {
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

    List<ContactObject> _results = [];

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

  void stopSearching(BuildContext context) {
    loadItems(context);
    notifyListeners();
  }
}
