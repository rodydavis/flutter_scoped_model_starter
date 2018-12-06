import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/crud.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/app/app_search_bar.dart';
import 'crud_list.dart';
import 'edit/crud_edit.dart';

final CRUDModel crudModel = CRUDModel();

class CRUDScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<CRUDModel>(
      model: crudModel,
      child: _CRUDScreen(crudModel),
    );
  }
}

class _CRUDScreen extends StatefulWidget {
  final CRUDModel model;
  _CRUDScreen(this.model);
  @override
  __CRUDScreenState createState() => __CRUDScreenState();
}

class __CRUDScreenState extends State<_CRUDScreen> {
  @override
  void initState() {
    widget.model.loadItems();
    super.initState();
  }

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
      body: CRUDList(model: _model),
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
