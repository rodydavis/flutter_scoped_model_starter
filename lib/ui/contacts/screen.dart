import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/contacts/list.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../app/app_refresh_button.dart';
import '../app/app_search_bar.dart';
import '../app/app_sort_button.dart';
import '../general/list_widget.dart';
import '../general/simple_fab.dart';
import 'edit.dart';
import 'item.dart';

class ContactsScreen extends StatelessWidget {
  final ContactModel model;
  ContactsScreen({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactModel>(
      model: model,
      child: Scaffold(
          appBar: AppBar(
            title: new ScopedModelDescendant<ContactModel>(
                builder: (context, child, model) => AppSearchBar(
                      isSearching: model.isSearching,
                      name: model.title,
                      search: model.searchValue,
                      onSearchChanged: model.searchChanged,
                    )),
            actions: <Widget>[
              new ScopedModelDescendant<ContactModel>(
                  builder: (context, child, model) => AppSearchButton(
                        isSearching: model.isSearching,
                        onSearchPressed: model.searchPressed,
                      )),
            ],
          ),
          drawer: AppDrawer(),
          body: new ScopedModelDescendant<ContactModel>(
              builder: (context, child, model) => RefreshIndicator(
                    onRefresh: model.refresh,
                    child: ListWidget(
                      items: model.contacts,
                      child: ListView.builder(
                        itemCount: model?.contacts?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _info = model.contacts[index];
                          if (index == model.contacts.length - 1)
                            model.fetchNext();
                          return ContactItem(model: model, contact: _info);
                        },
                      ),
                    ),
                  )),
          bottomNavigationBar: AppBottomBar(
            buttons: [
              new ScopedModelDescendant<ContactModel>(
                  builder: (context, child, model) => AppSortButton(
                        sort: model.sort,
                        sortChanged: model.sortChanged,
                      )),
              new ScopedModelDescendant<ContactModel>(
                  builder: (context, child, model) => AppRefreshButton(
                        isRefreshing: model.fetching,
                        onRefresh: model.refresh,
                      )),
              IconButton(
                tooltip: "Contact Tasks",
                icon: Icon(Icons.event),
                onPressed: () {
                  Navigator.pushNamed(context, "/contact_tasks");
                },
              ),
              IconButton(
                tooltip: "Contact Groups",
                icon: Icon(Icons.group),
                onPressed: () {
                  Navigator.pushNamed(context, "/contact_groups");
                },
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.add),
            onPressed: () => createContact(context, model: model),
          )),
    );
  }
}
