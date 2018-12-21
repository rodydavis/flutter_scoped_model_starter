import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/leads/list.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import '../app/app_search_bar.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_sort_button.dart';
import '../general/list_widget.dart';
import '../general/simple_fab.dart';
import 'edit.dart';
import 'item.dart';
import '../phone_contacts/import.dart';
import '../../data/classes/leads/lead_details.dart';
import '../../data/models/leads/groups.dart';

class LeadsScreen extends StatelessWidget {
  final LeadModel model;
  final LeadGroupModel groupModel;
  LeadsScreen({this.model, @required this.groupModel});

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
          body: new ScopedModelDescendant<LeadModel>(
              builder: (context, child, model) => RefreshIndicator(
                    onRefresh: model.refresh,
                    child: ListWidget(
                      items: model.leads,
                      child: ListView.builder(
                        itemCount: model?.leads?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _lead = model.leads[index];
                          if (index == model.leads.length - 1 &&
                              !model.isSearching) model.fetchNext();
                          return LeadItem(
                              model: model,
                              lead: _lead,
                              groupModel: groupModel);
                        },
                      ),
                    ),
                  )),
          bottomNavigationBar: AppBottomBar(
            buttons: [
              new ScopedModelDescendant<LeadModel>(
                  builder: (context, child, model) => AppSortButton(
                        sort: model.sort,
                        sortChanged: model.sortChanged,
                      )),
              new ScopedModelDescendant<LeadModel>(
                  builder: (context, child, model) => AppRefreshButton(
                        isRefreshing: model.fetching,
                        onRefresh: model.refresh,
                        onCancel: model.cancel,
                      )),
              IconButton(
                tooltip: "Lead Tasks",
                icon: Icon(Icons.event),
                onPressed: () {
                  Navigator.pushNamed(context, "/lead_tasks");
                },
              ),
              IconButton(
                tooltip: "Lead Groups",
                icon: Icon(Icons.group),
                onPressed: () {
                  Navigator.pushNamed(context, "/lead_groups");
                },
              ),
              new ScopedModelDescendant<LeadModel>(
                  builder: (context, child, model) => IconButton(
                        tooltip: "Import Phone Contacts",
                        icon: Icon(Icons.import_contacts),
                        onPressed: () =>
                            selectMultipleContacts(context).then((contacts) {
                              List<LeadDetails> _items = [];
                              if (contacts != null) {
                                for (var _item in contacts) {
                                  var _details =
                                      LeadDetails.fromPhoneContact(_item);
                                  _items.add(_details);
                                }
                              }
                              if (_items.isNotEmpty) {
                                model.importItems(items: _items);
                              }
                            }),
                      )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.add),
            onPressed: () =>
                createLead(context, model: model, groupModel: groupModel),
          )),
    );
  }
}
