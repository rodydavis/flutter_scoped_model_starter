import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../classes/app/paging.dart';
import '../classes/contacts/contact_details.dart';
import '../classes/contacts/contact_module.dart';
import '../classes/contacts/contact_row.dart';
import '../models/auth_model.dart';
import '../repositories/contact_repository.dart';

class ContactModel extends Model {
  ContactModule _module;

  bool get lastPage => _module.lastPage;

  Future<bool> nextPage(BuildContext context) async {
    _module.paging = Paging(
      rows: _module.paging.rows,
      page: _module.paging.page + 1,
    );

    await loadItems(context, nextFetch: true);

    if (_module.lastPage) {
      _module.paging = Paging(
        rows: _module.paging.rows,
        page: _module.paging.page - 1,
      );
    }

    notifyListeners();
    return true;
  }

  Future refresh(BuildContext context) async {
    // _loaded = false;
    // notifyListeners();

    _module.paging = Paging(rows: 100, page: 1);

    await loadItems(context);
    notifyListeners();
  }

  bool _loaded = false;
  int _lastUpdated = 0;

  List<ContactRow> _items = [];
  List<ContactRow> _filtered = [];

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

  List<ContactRow> get items => _items;
  List<ContactRow> get filteredItems => _filtered;

  Future<bool> loadItems(BuildContext context, {bool nextFetch = false}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    // -- Load Items from API or Local --
    var _contacts =
        await ContactRepository().loadList(_auth, paging: _module.paging);

    List<dynamic> _result = _contacts?.result;
    if (_result?.isEmpty ?? true) {
      _module.lastPage = true;
    } else {
      _module.lastPage = false;
    }

    var _results = _result
        ?.map((e) =>
            e == null ? null : ContactRow.fromJson(e as Map<String, dynamic>))
        ?.toList();

    if (_results != null && _results.isNotEmpty) {
      if (nextFetch) {
        _items.addAll(_results);
      } else {
        _items = _results;
      }
    }

    _lastUpdated = DateTime.now().millisecondsSinceEpoch;
    notifyListeners();
    return true;
  }

  Future<bool> addItem(BuildContext context,
      {@required ContactDetails item}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    print("Adding Item => ${item?.firstName}");
    var _result = await ContactRepository().saveData(_auth, contact: item);
    notifyListeners();
    print("Status: $_result");
    if (_result) {
      refresh(context);
      return true;
    }
    return false;
  }

  Future<bool> editItem(BuildContext context,
      {@required ContactDetails item, @required String id}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    print("Editing Item => $id");
    var _result =
        await ContactRepository().saveData(_auth, contact: item, id: id);
    notifyListeners();
    print("Status: $_result");
    if (_result) {
      refresh(context);
      return true;
    }
    return false;
  }

  Future<bool> deleteItem(BuildContext context, {@required String id}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    print("Deleting Item => $id");
    var _result = await ContactRepository().deleteContact(_auth, id: id);
    notifyListeners();
    print("Status: $_result");
    if (_result) {
      refresh(context);
      return true;
    }
    return false;
  }

  Future<bool> importItems(BuildContext context,
      {@required List<ContactDetails> items}) async {
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    _auth.confirmUserChange();
    print("Adding Items => ${items?.toString()}");
    var _result = await ContactRepository().importData(_auth, contacts: items);
    notifyListeners();
    print("Status: $_result");
    if (_result) {
      refresh(context);
      return true;
    }
    return false;
  }

  void sort(String field, bool ascending) {
    _items.sort((a, b) => a.compareTo(b, field, ascending));
    notifyListeners();
  }

  void search(String value) {
    print("Searching... $value");

    List<ContactRow> _results = [];

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
    try {
      var _info = ContactDetails.fromJson(_result?.result);
      return _info;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
