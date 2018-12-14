import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../data/classes/general/address.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/two_letter_name.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_search_bar.dart';
import '../general/address_tile.dart';
import '../general/email_tile.dart';
import '../general/list_widget.dart';
import '../general/phone_tile.dart';
import '../general/profile_avatar.dart';
import '../../data/classes/general/phone.dart';

class ImportContactsScreen extends StatefulWidget {
  final bool selectSingle;
  ImportContactsScreen({this.selectSingle = false});
  @override
  ImportContactsScreenState createState() => ImportContactsScreenState();
}

class ImportContactsScreenState extends State<ImportContactsScreen> {
  List<ContactSelect> _contacts = [];
  List<ContactSelect> _filteredContacts = [];
  bool _isSearching = false;
  int _selectedContacts = 0;

  @override
  void initState() {
    // Get all contacts
    _loadContacts();
    super.initState();
  }

  void _loadContacts({bool search = false, String query = ""}) async {
    try {
      var contacts =
          await ContactsService.getContacts(query: search ? query : null);
      // final _items = contacts
      //     .map((Contact item) => ContactSelect(contact: item, selected: false))
      //     .toList();
      var _items = <ContactSelect>[];
      if (contacts != null && contacts.isNotEmpty)
        for (var _item in contacts) {
          if (!isNullOrEmpty(_item?.displayName)) {
            _items.add(ContactSelect(contact: _item, selected: false));
          }
        }

      setState(() {
        if (!search) _contacts = _items;
        _filteredContacts = _items;
      });
    } catch (e) {
      print(e);
    }
    _updateCount();
  }

  void _viewContact(BuildContext context, {Contact contact}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => _ContactDetailsScreen(contact: contact)),
    );
  }

  void _selectAll({bool deselect = false}) {
    if (_contacts != null && _contacts.isNotEmpty)
      for (var _item in _contacts) {
        setState(() {
          if (deselect) {
            _item?.selected = false;
          } else {
            _item?.selected = true;
          }
        });
      }
    _updateCount();
  }

  void _updateCount() {
    int _count = 0;
    if (_contacts != null && _contacts.isNotEmpty)
      for (var _item in _contacts) {
        if (_item?.selected == true) {
          _count++;
        }
      }
    setState(() {
      _selectedContacts = _count;
    });
  }

  void _importSelectedContacts(BuildContext context) {
    if (widget.selectSingle) {
      Contact _value;
      if (_contacts != null && _contacts.isNotEmpty) {
        for (var _item in _contacts) {
          if (_item?.selected == true) {
            _value = _item?.contact;
          }
        }
      }
      Navigator.pop(context, _value);
    } else {
      List<Contact> _items = [];
      if (_contacts != null && _contacts.isNotEmpty) {
        for (var _item in _contacts) {
          if (_item?.selected == true) {
            _items.add(_item?.contact);
          }
        }
      }
      Navigator.pop(context, _items);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool _allSelected = _selectedContacts == _contacts?.length;
    // List<ContactSelect> items = _isSearching ? _filteredContacts : _contacts;
    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(
          name: "Phone Contacts",
          isSearching: _isSearching,
          onSearchChanged: (String value) {
            if (!isNullOrEmpty(value)) {
              _loadContacts(search: true, query: value);
            } else {
              setState(() {
                _filteredContacts = _contacts;
              });
            }
          },
        ),
        actions: <Widget>[
          AppSearchButton(
            isSearching: _isSearching,
            onSearchPressed: () {
              setState(() {
                _isSearching = !_isSearching;
                _filteredContacts = _contacts;
              });
            },
          )
        ],
      ),
      body: ListWidget(
          items: _isSearching ? _filteredContacts : _contacts,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  _getLabelText(all: _allSelected, count: _selectedContacts),
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    (_isSearching ? _filteredContacts : _contacts)?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  var _item =
                      (_isSearching ? _filteredContacts : _contacts)[index];
                  final _contact = _item.contact;
                  final _selected = _item?.selected ?? false;
                  return ListTile(
                    selected: _item?.selected,
                    leading: AvatarWidget(
                      imageURL: "",
                      noImageText: convertNamesToLetters(
                        _contact?.givenName,
                        _contact?.familyName,
                      ),
                    ),
                    title: Text(isNullOrEmpty(_contact?.displayName)
                        ? "No Name Found"
                        : _contact?.displayName),
                    subtitle: isNullOrEmpty(_contact?.company)
                        ? null
                        : Text(_contact?.company),
                    trailing: IconButton(
                      icon: Icon(Icons.info),
                      onPressed: () => _viewContact(context, contact: _contact),
                    ),
                    onTap: () {
                      if (widget.selectSingle) {
                        _selectAll(deselect: true);
                        setState(() {
                          _item?.selected = !_selected;
                        });
                      } else {
                        print("Selected => ${_item?.contact?.displayName}");

                        setState(() {
                          _item?.selected = !_selected;
                        });

                        if (_isSearching) {
                          for (var _newItem in _contacts) {
                            if (_newItem.contact.displayName ==
                                _item.contact.displayName) {
                              setState(() {
                                _newItem?.selected = !_selected;
                              });
                            }
                          }
                        }
                      }
                      _updateCount();
                    },
                    onLongPress: () => _viewContact(context, contact: _contact),
                  );
                },
              ),
            ],
          )),
      bottomNavigationBar: AppBottomBar(
        showSort: false,
        buttons: [
          IconButton(
            tooltip: _allSelected ? "Deselect All" : "Select All",
            icon: Icon(
              Icons.select_all,
              color: _allSelected ? Colors.blue : null,
            ),
            onPressed: widget.selectSingle || _isSearching
                ? null
                : () =>
                    _allSelected ? _selectAll(deselect: true) : _selectAll(),
          ),
          IconButton(
            tooltip: "Refresh",
            icon: Icon(Icons.refresh),
            onPressed: () => _loadContacts(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: _selectedContacts == 0
          ? null
          : FloatingActionButton(
              tooltip: "Import Contacts",
              child: Icon(Icons.save),
              heroTag: "Import",
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => _importSelectedContacts(context),
            ),
    );
  }

  String _getLabelText({bool all, int count}) {
    if (all) return "All Contacts Selected";
    if (count == 0) return "No Contacts Selected";
    if (count == 1) return "Contact $count Selected";
    return "Contacts $count Selected";
  }
}

class ContactSelect {
  final Contact contact;
  bool selected;

  ContactSelect({
    this.contact,
    this.selected = false,
  });
}

class _ContactDetailsScreen extends StatelessWidget {
  final Contact contact;
  _ContactDetailsScreen({this.contact});
  @override
  Widget build(BuildContext context) {
    var _details = <Widget>[
      ListTile(
        leading: Icon(Icons.person),
        title: Text(isNullOrEmpty(contact?.displayName)
            ? "No Name Found"
            : contact?.displayName),
        subtitle:
            isNullOrEmpty(contact?.company) ? null : Text(contact?.company),
      ),
    ];
    if (contact?.phones != null && contact.phones.isNotEmpty) {
      var _phones = getPhones(context, items: contact.phones.toList());
      _details.addAll(_phones);
    }
    if (contact?.emails != null && contact.emails.isNotEmpty) {
      var _emails = getEmails(context, items: contact.emails.toList());
      _details.addAll(_emails);
    }
    if (contact?.postalAddresses != null &&
        contact.postalAddresses.isNotEmpty) {
      var _addresses =
          getAddresses(context, items: contact.postalAddresses.toList());
      _details.addAll(_addresses);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: _details,
        ),
      ),
    );
  }

  List<Widget> getPhones(BuildContext context, {@required List<Item> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(PhoneTile(
        label: _item?.label,
        number: _item?.value != null && _item.value.isNotEmpty
            ? Phone.fromString(_item?.value)
            : null,
        icon: getIcon(_item?.label ?? ""),
      ));
    }
    return _widgets;
  }

  List<Widget> getEmails(BuildContext context, {@required List<Item> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(
        EmailTile(
          label: _item?.label,
          email: _item?.value,
        ),
      );
    }
    return _widgets;
  }

  List<Widget> getAddresses(BuildContext context,
      {@required List<PostalAddress> items}) {
    var _widgets = <Widget>[];
    for (var _item in items) {
      _widgets.add(
        AddressTile(
          label: _item?.label,
          address: Address(
            street: _item?.street,
            state: _item?.region,
            city: _item?.city,
            zip: _item?.postcode,
          ),
        ),
      );
    }
    return _widgets;
  }

  IconData getIcon(String name) {
    if (name.contains("mobile")) return Icons.phone;
    if (name.contains("work")) return Icons.work;
    if (name.contains("fax")) return Icons.print;
    if (name.contains("home")) return Icons.home;
    return Icons.phone;
  }
}
