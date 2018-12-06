import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/crud.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_search_bar.dart';
import 'crud_list.dart';
import 'edit/crud_edit.dart';

class CRUDScreen extends StatelessWidget {
  final CRUDModel model;
  CRUDScreen({@required this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CRUDModel>(
      model: model,
      child: _CRUDScreen(),
    );
  }
}

class _CRUDScreen extends StatefulWidget {
  @override
  __CRUDScreenState createState() => __CRUDScreenState();
}

class __CRUDScreenState extends State<_CRUDScreen> {
  bool _isSearching = false;
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CRUDModel>(context, rebuildOnChange: true);
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
          return CRUDList(model: _model);
        },
      ),
      bottomNavigationBar: AppBottomBar(
        buttons: [
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: null,
          ),
        ],
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
