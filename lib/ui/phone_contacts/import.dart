import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../utils/null_or_empty.dart';
import '../../utils/two_letter_name.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_search_bar.dart';
import '../general/list_widget.dart';
import '../general/profile_avatar.dart';
import 'details.dart';

class ImportContactsScreen extends StatefulWidget {
  final bool selectSingle;
  ImportContactsScreen({this.selectSingle = false});
  @override
  ImportContactsScreenState createState() => ImportContactsScreenState();
}

class ImportContactsScreenState extends State<ImportContactsScreen> {
  bool _isSearching = false;
  String _search = "";

  void _selectAll({bool deselect = false}) {
    if (deselect) {
      setState(() {
        _selectedItems.clear();
      });
    } else {
      if (_contactItems != null && _contactItems.isNotEmpty)
        for (var _item in _contactItems) {
          setState(() {
            if (!_selectedItems.contains(_item)) _selectedItems.add(_item);
          });
        }
    }
  }

  void _importSelectedContacts(BuildContext context) {
    Navigator.pop(
      context,
      widget.selectSingle ? _selectedItems?.first : _selectedItems,
    );
  }

  List<Contact> _selectedItems = [];
  List<Contact> _contactItems = [];

  @override
  Widget build(BuildContext context) {
    final bool _allSelected =
        (_contactItems?.length == _selectedItems?.length) &&
            _contactItems.isNotEmpty;
    final _list = _selectedItems;
    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(
          name: "Phone Contacts",
          isSearching: _isSearching,
          onSearchChanged: (String value) {
            setState(() {
              _search = value;
            });
          },
        ),
        actions: <Widget>[
          AppSearchButton(
            isSearching: _isSearching,
            onSearchPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: ContactsService.getContacts(
                  query: _isSearching && _search.isNotEmpty ? _search : null)
              .asStream(),
          builder: (BuildContext context,
              AsyncSnapshot<Iterable<Contact>> snapshot) {
            if (snapshot.hasData) {
              final List<Contact> _items = snapshot.data.toList();

              if (_items.isEmpty) {
                return Center(child: Text("No Contacts Found"));
              }
              _contactItems = _items;
//              final _itemsSelected = _selectedItems;
              return ListView.builder(
                itemCount: _items?.length,
                itemBuilder: (BuildContext context, int index) {
                  final _item = _items[index];
                  bool _selected = false;
                  for (var _row in _list) {
                    if (_item.displayName == _row.displayName) _selected = true;
                  }

                  return ListTile(
                    leading: AvatarWidget(
                      imageURL: "",
                      noImageText: convertNamesToLetters(
                        _item?.givenName,
                        _item?.familyName,
                      ),
                    ),
                    title: Text(isNullOrEmpty(_item?.displayName)
                        ? "No Name Found"
                        : _item?.displayName),
                    subtitle: isNullOrEmpty(_item?.company)
                        ? null
                        : Text(_item?.company),
                    trailing: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () => viewContact(context,
                                  contact: _item, selected: _selected)
                              .then((selected) {
                            if (selected != null)
                              _toggleItem(_item,
                                  selected: _selected, list: _list);
                          }),
                    ),
                    onLongPress: () => viewContact(context,
                                contact: _item, selected: _selected)
                            .then((selected) {
                          if (selected != null)
                            _toggleItem(_item,
                                selected: _selected, list: _list);
                        }),
                    onTap: () =>
                        _toggleItem(_item, selected: _selected, list: _list),
                    selected: _selected ?? false,
                  );
                },
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
      bottomNavigationBar: AppBottomBar(
        // showSort: false,
        buttons: [
          widget.selectSingle
              ? Container(height: 48.0)
              : _allSelected
                  ? IconButton(
                      tooltip: "Deselect All",
                      icon: Icon(
                        Icons.select_all,
                        color: Colors.blue,
                      ),
                      onPressed: () => _selectAll(deselect: true),
                    )
                  : IconButton(
                      tooltip: "Select All",
                      icon: Icon(
                        Icons.select_all,
                        color: null,
                      ),
                      onPressed: () => _selectAll(),
                    ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _selectedItems?.isEmpty ?? true
          ? null
          : FloatingActionButton(
              tooltip: "Import Contacts",
              child: widget.selectSingle
                  ? Icon(Icons.file_download)
                  : Text(_selectedItems.length.toString()),
              heroTag: "Import",
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => _importSelectedContacts(context),
            ),
    );
  }

  void _toggleItem(Contact item, {bool selected = false, List<Contact> list}) {
    print("$selected Item => " + item?.displayName);
    if (selected) {
      var toRemove = [];
      for (var _row in list) {
        if (item.displayName == _row.displayName) toRemove.add(_row);
      }
      setState(() {
        _selectedItems.removeWhere((e) => toRemove.contains(e));
      });
    } else {
      if (widget.selectSingle) {
        _selectedItems.clear();
      }
      setState(() {
        _selectedItems.add(item);
      });
    }
    print(list);
  }
}

Future<Contact> selectSingleContact(BuildContext context) async {
  print("Selecting Single Contact...");
  dynamic value = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ImportContactsScreen(selectSingle: true),
        fullscreenDialog: true,
      ));

  if (value != null) {
    Contact _contact = value;
    print("Phone Contact => " + _contact.toString());
    return _contact;
  }

  return null;
}

Future<List<Contact>> selectMultipleContacts(BuildContext context) async {
  dynamic value = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new ImportContactsScreen(selectSingle: false),
        fullscreenDialog: true,
      ));
  if (value != null) {
    List<Contact> _contacts = value;
    return _contacts;
  }

  return [];
}
