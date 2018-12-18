import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../general/simple_fab.dart';
import '../app/app_search_bar.dart';
import '../../data/models/lead_model.dart';

class LeadsScreen extends StatelessWidget {
  final LeadModel model;
  LeadsScreen({this.model});
  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadModel>(
      model: model,
      child: Scaffold(
          appBar: AppBar(
            title: new ScopedModelDescendant<LeadModel>(
                builder: (context, child, model) => AppSearchBar(
                      isSearching: model.isSearching,
                      name: model.title,
                      search: model.searchValue,
                      onSearchChanged: model.searchChanged,
                    )),
            actions: <Widget>[
              new ScopedModelDescendant<LeadModel>(
                  builder: (context, child, model) => AppSearchButton(
                        isSearching: model.isSearching,
                        onSearchPressed: model.searchPressed,
                      )),
            ],
          ),
          drawer: AppDrawer(),
          body: Container(),
          bottomNavigationBar: AppBottomBarStateless(
            buttons: [
              IconButton(
                icon: Icon(Icons.sort_by_alpha),
                onPressed: () => _sortPressed(),
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.add),
            onPressed: () => _fabPressed(),
          )),
    );
  }

  void _fabPressed() {}

  void _sortPressed() {}
}
