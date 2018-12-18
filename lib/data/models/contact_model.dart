import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../constants.dart';
import '../classes/app/paging.dart';
import '../classes/app/sort.dart';
import '../classes/contacts/contact_details.dart';
import '../classes/contacts/contact_module.dart';
import '../classes/contacts/contact_row.dart';
import '../classes/unify/contact_group.dart';
import '../models/auth_model.dart';
import '../repositories/contact_group_repoistory.dart';
import '../repositories/contact_repository.dart';

class ContactModel extends Model {
  static ContactModel of(BuildContext context) =>
      ScopedModel.of<ContactModel>(context);

  ContactModule _module = ContactModule(
    contacts: [],
    filtered: [],
    lastPage: false,
    isLoaded: false,
    lastUpdated: 0,
    paging: Paging(rows: 100, page: 1),
    sorting: Sort(
        initialized: true,
        ascending: true,
        field: ContactFields.last_name,
        fields: [
          ContactFields.first_name,
          ContactFields.last_name,
          // ContactFields.last_activity,
        ]),
    groups: [],
  );

  Sort get sorting => _module?.sorting;

  void sortChanged(Sort value) {
    _module.sorting = value;
    sort(_module.sorting?.field, _module.sorting?.ascending);
    notifyListeners();
  }

  bool get lastPage => _module?.lastPage ?? false;

  int get lastUpdated => _module?.lastUpdated ?? 0;

  bool get isLoaded {
    if (isStale) return false;
    return _module?.isLoaded ?? false;
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
    _module?.isLoaded = true;
    notifyListeners();
  }

  List<ContactGroup> get groups => _module?.groups ?? [];
  List<ContactRow> get items => _module?.contacts ?? [];
  List<ContactRow> get filteredItems => _module?.filtered ?? [];

  Future<bool> loadContactGroups(BuildContext context,
      {bool force = false, @required AuthModel auth}) async {
    // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    auth.confirmUserChange();

    var _groups = await ContactGroupRepository().getContactGroups(auth);
    if (force) {
      _module.groups.clear();
      notifyListeners();
    }

    List<dynamic> _result = _groups?.result;

    var _results = _result
        ?.map((e) =>
            e == null ? null : ContactGroup.fromJson(e as Map<String, dynamic>))
        ?.toList();

    _module.groups = _results;

    notifyListeners();
    return true;
  }

  Future<bool> editContactGroup(BuildContext context,
      {@required ContactGroup model,
      bool isNew = true,
      @required AuthModel auth}) async {
    // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    auth.confirmUserChange();

    bool _valid = true;
    if (isNew) {
      _valid = await ContactGroupRepository()
          .addContactGroup(auth, name: model?.name);
    } else {
      _valid = await ContactGroupRepository()
          .editContactGroup(auth, name: model?.name, id: model?.id);
    }

    _module.groups.clear();
    notifyListeners();

    loadContactGroups(context, force: true, auth: auth);

    notifyListeners();
    return true;
  }

  Future<bool> deleteContactGroup(BuildContext context,
      {@required String id, @required AuthModel auth}) async {
    // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    auth.confirmUserChange();

    _module.groups.clear();
    notifyListeners();

    bool _valid =
        await ContactGroupRepository().deleteContactGroup(auth, id: id);

    loadContactGroups(context, force: true, auth: auth);

    notifyListeners();
    return true;
  }

  Future<List<ContactRow>> getContactsForContactGroup(BuildContext context,
      {@required String id,
      @required AuthModel auth,
      @required Paging paging}) async {
    // final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);
    auth.confirmUserChange();

    var _contacts = await ContactGroupRepository()
        .getContactsFromGroup(auth, paging: paging, id: id);

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

    return _results;
  }

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
        _module?.contacts?.addAll(_results);
      } else {
        _module?.contacts = _results;
      }
    }

    _module?.lastUpdated = DateTime.now().millisecondsSinceEpoch;

    sort(_module.sorting?.field, _module.sorting?.ascending);

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
    _module?.contacts?.sort((a, b) => a.compareTo(b, field, ascending));
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

    _module?.filtered = _results;
    notifyListeners();
  }

  void startSearching() {
    _module?.filtered = _module?.contacts;
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
