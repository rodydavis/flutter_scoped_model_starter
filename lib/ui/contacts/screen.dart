import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_sort_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/contacts/list.dart';
import '../app/app_bottom_bar.dart';
import '../app/app_drawer.dart';
import '../app/app_search_bar.dart';
import '../general/list_widget.dart';
import '../general/simple_fab.dart';
import '../phone_contacts/import.dart';
import 'edit.dart';
import '../../data/classes/contacts/contact_details.dart';
import 'item.dart';
import '../../data/models/contacts/groups.dart';

class ContactsScreen extends StatelessWidget {
  final ContactModel model;
  final ContactGroupModel groupModel;

  ContactsScreen({this.model, @required this.groupModel});

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
                          if (index == model.contacts.length - 1 &&
                              !model.isSearching) model.fetchNext();
                          return ContactItem(
                              model: model,
                              contact: _info,
                              groupModel: groupModel);
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
                        onCancel: model.cancel,
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
              new ScopedModelDescendant<ContactModel>(
                  builder: (context, child, model) => IconButton(
                        tooltip: "Import Phone Contacts",
                        icon: Icon(Icons.import_contacts),
                        onPressed: () =>
                            selectMultipleContacts(context).then((contacts) {
                              List<ContactDetails> _items = [];
                              if (contacts != null) {
                                for (var _item in contacts) {
                                  var _details =
                                      ContactDetails.fromPhoneContact(_item);
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
                createContact(context, model: model, groupModel: groupModel),
          )),
    );
  }
}
