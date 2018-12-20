import 'package:scoped_model/scoped_model.dart';
import '../../classes/unify/contact_group.dart';
import '../../repositories/contacts/groups.dart';
import '../../classes/contacts/contact_row.dart';
import 'package:flutter/foundation.dart';
import '../auth_model.dart';
import 'package:flutter/material.dart';
import '../../classes/app/paging.dart';
import '../../classes/app/sort.dart';

class ContactGroupModel extends Model {
  final AuthModel auth;
  final String id;

  ContactGroupModel({@required this.auth, this.id});

  List<ContactGroup> _groups;

  List<ContactGroup> get groups {
    if (_groups == null) {
      getGroups();
    }
    return _groups;
  }

  bool _success = true;

  bool get success => _success;

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool _fetching = false;

  bool get fetching => _fetching;

  Future getGroups({bool force = false}) async {
    if (force) {
      if (_groups != null && _groups.isNotEmpty) _groups.clear();
      notifyListeners();
    }

    await _loadGroupList();
  }

  Future _loadGroupList({bool nextPage = false}) async {
    _isLoaded = false;
    notifyListeners();

    if (!_fetching) {
      _fetching = true;
      var _items = await ContactGroupRepository().getContactGroups(auth);

      List<dynamic> _result = _items?.result;

      if (_result?.isEmpty ?? true) {
//        _lastPage = true;
//        _paging.page -= 1;
        _groups = [];
      } else {
        var _results = _result
            ?.map((e) => e == null
                ? null
                : ContactGroup.fromJson(e as Map<String, dynamic>))
            ?.toList();

        if (nextPage) {
          _groups.addAll(_results);
        } else {
          _groups = _results ?? [];
        }

//        _lastPage = false;
        _fetching = false;
      }

      _isLoaded = true;
    }

    notifyListeners();
  }

  Future refreshGroups() async {
    await getGroups(force: true);
  }

  Future editContactGroup({
    @required ContactGroup model,
    bool isNew = true,
  }) async {
    _isLoaded = false;
    _fetching = true;
    notifyListeners();

    if (isNew) {
      _success = await ContactGroupRepository()
          .addContactGroup(auth, name: model?.name);
    } else {
      _success = await ContactGroupRepository()
          .editContactGroup(auth, name: model?.name, id: model?.id);
    }

    _groups.clear();
    notifyListeners();

    getGroups(force: true);

    _isLoaded = true;
    _fetching = false;
    notifyListeners();
  }

  Future deleteContactGroup({@required String id}) async {
    _isLoaded = false;
    _fetching = true;
    notifyListeners();

    _groups.clear();
    notifyListeners();

    _success = await ContactGroupRepository().deleteContactGroup(auth, id: id);

    getGroups(force: true);

    _isLoaded = true;
    _fetching = false;
    notifyListeners();
  }

  // -- Contacts For Group --

  // -- Search --
  String _searchValue = "";
  bool _isSearching = false;

  String get searchValue => _searchValue;
  bool get isSearching => _isSearching;

  void searchPressed() {
    _isSearching = !_isSearching;
    notifyListeners();
  }

  void searchChanged(String value) {
    _searchValue = value;

    print("Searching... $value");

    // -- Local Search --
    List<ContactRow> _results = [];

    if (_contacts != null && _contacts.isNotEmpty) {
      for (var _item in _contacts) {
        if (_item.matchesSearch(value)) {
          _results.add(_item);
        }
      }
      _filtered = _results;
    }

    notifyListeners();
  }

  // -- Sort --
  Sort _sort = Sort(
    initialized: true,
    ascending: true,
    field: ContactFields.last_name,
    fields: [
      ContactFields.last_name,
      ContactFields.first_name,
    ],
  );

  Sort get sort => _sort;

  void sortChanged(Sort value) {
    _sort = value;
    notifyListeners();
  }

  void _sortList(String field, bool ascending) {
    _contacts?.sort((a, b) => a.compareTo(b, field, ascending));
    notifyListeners();
  }

  List<ContactRow> _contacts, _filtered;

  List<ContactRow> get contacts {
    // -- Searching --
    if (_isSearching) {
      if (_filtered == null) {
        _filtered = _contacts;
      }
      _sortList(_sort?.field, _sort?.ascending);
      return _filtered;
    }

    if (_contacts == null || !_isLoaded) {
      _loadList();
    }
    _sortList(_sort?.field, _sort?.ascending);
    return _contacts;
  }

  Paging _paging = Paging(rows: 100, page: 1);

  bool _lastPage = false;

  bool get lastPage => _lastPage;

  Future refresh() async {
    print("Refreshing List...");
    _paging = Paging(rows: 100, page: 1);
    await _loadList();
  }

  Future getContacts() async {
    await _loadList();
  }

  Future _loadList({bool nextPage = false}) async {
    _isLoaded = false;
    notifyListeners();

    if (!_fetching) {
      _fetching = true;
      var _result = await ContactGroupRepository()
          .getContactsFromGroup(auth, id: id, paging: _paging);

      List<dynamic> _items = _result?.result ?? [];

      if (_items == null || (_items?.isEmpty ?? true)) {
        _lastPage = true;
        if (_paging.page == 1) _contacts = [];
        if (_paging.page >= 2) _paging.page -= 1;
      } else {
        var _results = _items
            ?.map((e) => e == null
                ? null
                : ContactRow.fromJson(e as Map<String, dynamic>))
            ?.toList();

        if (nextPage) {
          _contacts.addAll(_results);
        } else {
          _contacts = _results ?? [];
        }

        _lastPage = false;
      }
      _fetching = false;
      _isLoaded = true;
    }

    notifyListeners();
  }

  void fetchNext() {
    if (!_lastPage) {
      print("Fetching Next Page...");
      _paging.page += 1;
      _loadList(nextPage: true);
    }
  }

  void cancel() {
    _fetching = false;
    notifyListeners();
  }
}
