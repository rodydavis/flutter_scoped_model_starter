import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/crud_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_search_bar.dart';
import 'crud_list.dart';
import 'edit/crud_edit.dart';
import '../../data/models/sort_model.dart';

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
          return CRUDList(model: _model);
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
            onPressed: null,
          ),
        ],
        onChangeSortOrder: (bool value) {
          _sort.sortAscending = value;
          setState(() {
            _sortASC = value;
          });
          _model.changeSortOrder(_sortField, _sortASC);
        },
        onSelectedSortField: (String value) {
          _sort.sortField = value;
          setState(() {
            _sortField = value;
          });
          _model.changeSortOrder(_sortField, _sortASC);
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
              _model.changeSortOrder(_sortField, _sortASC);
            }
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'New Item',
      ),
    );
  }
}
