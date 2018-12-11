import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../constants.dart';
import '../../models/auth/model.dart';
import '../../models/paging_model.dart';
import '../../repositories/contact_repository.dart';
import 'list.dart';
import 'info.dart';

class ContactModel extends Model {
  // -- Paging --
  PagingModel _paging = PagingModel(rows: 100, page: 1);
  bool _lastPage = false;

  bool get lastPage => _lastPage;

  Future<bool> nextPage(BuildContext context) async {
    _paging = PagingModel(
      rows: _paging.rows,
      page: _paging.page + 1,
    );

    await loadItems(context, nextFetch: true);

    if (_lastPage) {
      _paging = PagingModel(
        rows: _paging.rows,
        page: _paging.page - 1,
      );
    }

    notifyListeners();
    return true;
  }

  Future refresh(BuildContext context) async {
    // _loaded = false;
    // notifyListeners();

    _paging = PagingModel(rows: 100, page: 1);

    await loadItems(context);
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

  Future<bool> loadItems(BuildContext context, {bool nextFetch = false}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    // -- Load Items from API or Local --
    var _contacts = await ContactRepository().loadList(_auth, paging: _paging);
    if (nextFetch) {
      if (_contacts?.result?.isEmpty ?? true) {
        _lastPage = true;
      } else {
        _lastPage = false;
      }
      _items.addAll(_contacts?.result);
    } else {
      _items = _contacts?.result;
    }

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

  Future<ContactDetails> getDetails(BuildContext context,
      {@required String id}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    var _result = await ContactRepository().getInfo(_auth, id: id);
    return _result?.result;
  }
}
