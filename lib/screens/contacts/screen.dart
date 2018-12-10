import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/contact/fields.dart';
import '../../data/models/contact/list.dart';
import '../../data/models/contact/model.dart';
import '../../data/models/sort_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_drawer.dart';
import '../../ui/app/app_search_bar.dart';
import 'edit.dart';
import 'list.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

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

  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<ContactModel>(context, rebuildOnChange: true);
    final _sort = ScopedModel.of<SortModel>(context, rebuildOnChange: true);

    return Scaffold(
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
          if (_model.isLoaded == false) {
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
          return ContactList(
            model: _model,
            isSearching: _isSearching,
          );
        },
      ),
      // body: ContactList(model: _model, isSearching: _isSearching),
      bottomNavigationBar: AppBottomBar(
        buttons: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => _model.refresh(context),
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
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactItemEdit(),
                fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              ContactObject _item = value;
              _model.addItem(_item);
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
