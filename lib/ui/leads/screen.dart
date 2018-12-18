import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../general/simple_fab.dart';
import '../app/app_search_bar.dart';
import '../app/app_sort_button.dart';
import '../../data/models/lead_model.dart';
import 'edit.dart';

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
              new ScopedModelDescendant<LeadModel>(
                  builder: (context, child, model) => AppSortButton(
                        sort: model.sort,
                        sortChanged: model.sortChanged,
                      )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.add),
            onPressed: () => createLead(context, model: model),
          )),
    );
  }
}
