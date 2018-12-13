import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/contacts/contact_details.dart';
import '../../data/models/auth/model.dart';
import '../../data/models/contact/fields.dart';
import '../../data/models/contact/model.dart';
import '../../data/models/sort_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_drawer.dart';
import '../../ui/app/app_search_bar.dart';
import 'edit.dart';
import 'list.dart';

class ContactScreen extends StatelessWidget {
  final ContactModel model;

  ContactScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactModel>(
      model: model,
      child: new ScopedModel<SortModel>(
        model: SortModel(
          defaultSortField: ContactFields.last_name,
          sortFields: [
            // STARTER: sort - do not remove comment
            ContactFields.first_name,

            ContactFields.last_name,

            ContactFields.last_activity,
          ],
        ),
        child: _ContactScreen(),
      ),
    );
  }
}

class _ContactScreen extends StatefulWidget {
  @override
  __ContactScreenState createState() => __ContactScreenState();
}

class __ContactScreenState extends State<_ContactScreen> {
  bool _isSearching = false;
  bool _sortASC = false;
  String _sortField = "";
  RefreshController _refreshController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(Widget child) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: child));
  }

  @override
  void initState() {
    _refreshController = new RefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<ContactModel>(context, rebuildOnChange: true);
    final _sort = ScopedModel.of<SortModel>(context, rebuildOnChange: true);
    final _auth = ScopedModel.of<AuthModel>(context, rebuildOnChange: true);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: AppSearchBar(
          name: "Contact" + "s",
          isSearching: _isSearching,
          onSearchChanged: (String value) {
            _model.search(value);
          },
        ),
        actions: <Widget>[
          AppSearchButton(
            isSearching: _isSearching,
            onSearchPressed: () {
              setState(() {
                _isSearching = !_isSearching;
              });
              if (_isSearching) {
                _model.startSearching();
              } else {
                _model.stopSearching(context);
              }
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        // future: _model.loadItems(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (_model.isLoaded == false || _auth.userChanged) {
            _model.loadItems(context);
            _model.loaded = true;
            return Center(child: CircularProgressIndicator());
          }
          if (_sortField.isEmpty) {
            _sortField = _sort.defaultSortField;
          }
          _sort.sortField = _sortField;
          _sort.sortAscending = _sortASC;
          _model.sort(_sortField, _sortASC);
          return new SmartRefresher(
              enablePullDown: true,
              enablePullUp: (_model?.items?.length ?? 0) > 10,
              controller: _refreshController,
              onRefresh: (up) {
                if (up) {
                  _model.refresh(context).then((_) {
                    _refreshController.sendBack(true, RefreshStatus.idle);
                    setState(() {});
                  });
                } else {
                  _model.nextPage(context).then((_) {
                    if (_model?.lastPage == true) {
                      print("No Items Found on Next Page");
                      showInSnackBar(Text("No More Items"));
                    } else {
                      _refreshController.scrollTo(
                          _refreshController.scrollController.offset + 100.0);
                    }
                    _refreshController.sendBack(false, RefreshStatus.idle);
                    setState(() {});
                  });
                }
              },
              // onOffsetChange: _onOffsetCallback,
              child: buildList(
                model: _model,
                isSearching: _isSearching,
              ));
        },
      ),
      // body: ContactList(model: _model, isSearching: _isSearching),
      bottomNavigationBar: AppBottomBar(
        buttons: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshController.requestRefresh(true);
              _model.refresh(context).then((_) {
                _refreshController.sendBack(true, RefreshStatus.idle);
                setState(() {});
              });
            },
          ),
          IconButton(
            tooltip: "Import Contacts",
            icon: Icon(Icons.import_contacts),
            onPressed: () =>
                Navigator.pushNamed(context, "/import").then((value) {
                  if (value != null) {
                    List<Contact> _items = value ?? [];
                    // Add Items
                    showInSnackBar(Text("Importing Contacts..."));
                    var _list = <ContactDetails>[];
                    for (var _item in _items) {
                      // ContactObject _contactObject = ContactObject(
                      //   firstName: _item?.givenName,
                      //   lastName: _item?.familyName,
                      // );
                      // _model.addItem(_contactObject);
                      // print("Adding... ${_contactObject?.firstName}");
                      _list.add(ContactDetails.fromPhoneContact(_item));
                    }
                    _model?.importItems(context, items: _list);
                  }
                }),
          ),
        ],
        onChangeSortOrder: (bool value) {
          setState(() {
            _sort.sortAscending = value;
            _sortASC = value;
            _model.sort(_sortField, _sortASC);
          });
        },
        onSelectedSortField: (String value) {
          if (_sortField.contains(value)) {
            setState(() {
              _sortASC = !_sortASC;
              _sort.sortAscending = _sortASC;
              _model.sort(_sortField, _sortASC);
            });
          } else {
            setState(() {
              _sort.sortField = value;
              _sortField = value;
              _model.sort(_sortField, _sortASC);
            });
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "Contact Add",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactItemEdit(model: _model),
                fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              ContactDetails _item = value;
              _model.addItem(context, item: _item);
              _model.sort(_sortField, _sortASC);
            }
          });
        },
        child: Icon(Icons.add, color: Colors.white),
        tooltip: 'New Item',
      ),
    );
  }
}
