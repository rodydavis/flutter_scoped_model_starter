import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../constants.dart';
import '../../classes/app/paging.dart';
import '../../classes/app/sort.dart';
import '../../classes/contacts/contact_details.dart';
import '../../classes/contacts/contact_row.dart';
import '../../repositories/contacts/contacts.dart';
import '../auth_model.dart';

class ContactModel extends Model {
  final AuthModel auth;

  ContactModel({@required this.auth});

  String get title => "Contacts";

  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  bool _fetching = false;

  bool get fetching => _fetching;

  int _lastUpdated = 0;

  int get lastUpdated => _lastUpdated;

  bool get isStale {
    if (lastUpdated == 0) return true;
    try {
      return DateTime.now().millisecondsSinceEpoch - lastUpdated >
          kMillisecondsToRefreshData;
    } catch (e) {
      print(e);
      return true;
    }
  }

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
    notifyListeners();

    print("Searching... $value");

    _loadList(query: _searchValue).then((_) {
      _filterResults();
    });
  }

  void _filterResults() {
    // -- Local Search --
    List<ContactRow> _results = [];

    if (_contacts != null && _contacts.isNotEmpty) {
      for (var _item in _contacts) {
        if (_item.matchesSearch(_searchValue)) {
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

  Future _loadList({bool nextPage = false, String query = ""}) async {
    _isLoaded = false;
    notifyListeners();

    if (!_fetching) {
      _fetching = true;
      var _items = await ContactRepository().loadList(auth, paging: _paging);

      List<dynamic> _result = _items?.result;

      if (_result?.isEmpty ?? true) {
        _lastPage = true;
        _paging.page -= 1;
        if (_paging.page == 1) _contacts = [];
      } else {
        var _results = _result
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
    }
    _isLoaded = true;
    notifyListeners();
  }

  void fetchNext() {
    if (!_lastPage) {
      print("Fetching Next Page...");
      _paging.page += 1;
      _loadList(nextPage: true);
    }
  }

  void importItems({@required List<ContactDetails> items}) async {
    if (!_fetching) {
      _fetching = true;
      print("Adding Items => ${items?.toString()}");
      var _result = await ContactRepository().importData(auth, contacts: items);
      notifyListeners();
      print("Status: $_result");
      if (_result) refresh();
      _fetching = false;
    }
    notifyListeners();
  }

  void cancel() {
    _fetching = false;
    notifyListeners();
  }
}
