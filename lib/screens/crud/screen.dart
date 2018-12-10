import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './../../ui/app/app_drawer.dart';
import '../../data/models/crud_model.dart';
import '../../data/models/sort_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_search_bar.dart';
import 'edit.dart';
import 'list.dart';

class CRUDScreen extends StatelessWidget {
  final CRUDModel model;

  CRUDScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CRUDModel>(
      model: model,
      child: new ScopedModel<SortModel>(
        model: SortModel(),
        child: _CRUDScreen(),
      ),
    );
  }
}

class _CRUDScreen extends StatefulWidget {
  @override
  __CRUDScreenState createState() => __CRUDScreenState();
}

class __CRUDScreenState extends State<_CRUDScreen> {
  bool _isSearching = false;
  bool _sortASC = false;
  String _sortField = CRUDFields.title;
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CRUDModel>(context, rebuildOnChange: true);
    final _sort = ScopedModel.of<SortModel>(context, rebuildOnChange: true);

    return Scaffold(
      appBar: AppBar(
        title: AppSearchBar(
          name: "CRUD",
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
                _model.stopSearching();
              }
            },
          )
        ],
      ),
       drawer: AppDrawer(),
      body: FutureBuilder(
        future: _model.loadItems(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          _sort.sortField = _sortField;
          _sort.sortFields = [
            // STARTER: sort - do not remove comment
            CRUDFields.title,

            CRUDFields.description,
          ];
          return CRUDList(model: _model, isSearching: _isSearching);
        },
      ),
      bottomNavigationBar: AppBottomBar(
        buttons: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              _model.loadDummyData();
            },
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
        heroTag: "CRUD Add",
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CRUDItemEdit(), fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              CRUDObject _item = value;
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
