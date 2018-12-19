import 'package:flutter/material.dart';

import '../../../data/classes/app/paging.dart';
import '../../../data/classes/contacts/contact_row.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/contacts/groups.dart';
import '../../../data/models/contacts/list.dart';
import '../item.dart';
import 'edit.dart';
import '../../../data/classes/unify/contact_group.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../general/list_widget.dart';
import '../../app/app_bottom_bar.dart';
import '../../app/app_search_bar.dart';
import '../../app/app_refresh_button.dart';
import '../../app/app_sort_button.dart';
//
//class ContactGroupList extends StatefulWidget {
//  final ContactGroup group;
//  final VoidCallback groupDeleted;
//  final ContactGroupModel model;
//  final ContactModel contactModel;
//
//  ContactGroupList({
//    this.group,
//    this.groupDeleted,
//    @required this.model,
//    @required this.contactModel,
//  });
//
//  @override
//  ContactGroupListState createState() {
//    return new ContactGroupListState();
//  }
//}
//
//class ContactGroupListState extends State<ContactGroupList> {
//  bool _isDisposed = false;
//  @override
//  void dispose() {
//    _isDisposed = true;
//    super.dispose();
//  }
//
//  List<ContactRow> _contacts;
//  Paging _paging = Paging(rows: 100, page: 1);
//
//  void _editGroup(BuildContext context,
//      {bool isNew = true, ContactGroup item}) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//          builder: (context) => EditContactGroup(
//                isNew: isNew,
//                group: item,
//                groupDeleted: () {
//                  Navigator.pop(context);
//                  widget.groupDeleted();
//                },
//              ),
//          fullscreenDialog: true),
//    ).then((value) {
//      if (value != null) {
//        Navigator.pop(context, value);
//      }
//    });
//  }
//
//  void _loadData() {
//    if (!_isDisposed)
//      setState(() {
//        _contacts = null;
//      });
//    widget.model.getContacts(widget.group?.id ?? "").then((items) {
//      final List<ContactRow> _items = items;
//      if (!_isDisposed)
//        setState(() {
//          _contacts = _items ?? [];
//        });
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    final appBar = AppBar(
//      title: Text(widget.group?.name ?? "Contact Group"),
//      actions: <Widget>[
//        IconButton(
//          icon: Icon(Icons.refresh),
//          onPressed: () => _loadData(),
//        ),
//        IconButton(
//          icon: Icon(Icons.edit),
//          onPressed: () =>
//              _editGroup(context, isNew: false, item: widget.group),
//        ),
//      ],
//    );
//
//    if (_contacts == null || _contacts.isEmpty) {
//      if (_contacts == null) {
//        _loadData();
//
//        return Scaffold(
//          appBar: appBar,
//          body: Center(
//            child: CircularProgressIndicator(),
//          ),
//        );
//      }
//
//      return Scaffold(
//        appBar: appBar,
//        body: Center(
//          child: Text("No Contacts Found"),
//        ),
//      );
//    }
//
//    return Scaffold(
//      appBar: appBar,
//      body: ListView.builder(
//        itemCount: _contacts?.length ?? 0,
//        itemBuilder: (BuildContext context, int index) {
//          final _item = _contacts[index];
//          return ContactItem(contact: _item, model: widget.contactModel);
//        },
//      ),
//    );
//  }
//}

class ContactsFromGroupScreen extends StatelessWidget {
  final ContactGroup group;
  final ContactModel contactModel;

  ContactsFromGroupScreen({
    @required this.contactModel,
    @required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactGroupModel>(
      model: ContactGroupModel(auth: contactModel?.auth, id: group?.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.name ?? "No Group Name"),
//          title: new ScopedModelDescendant<ContactGroupModel>(
//              builder: (context, child, model) => AppSearchBar(
//                    isSearching: model.isSearching,
//                    name: group.name,
//                    search: model.searchValue,
//                    onSearchChanged: model.searchChanged,
//                  )),
//          actions: <Widget>[
//            new ScopedModelDescendant<ContactGroupModel>(
//                builder: (context, child, model) => AppSearchButton(
//                      isSearching: model.isSearching,
//                      onSearchPressed: model.searchPressed,
//                    )),
//          ],
        ),
//        drawer: AppDrawer(),
        body: new ScopedModelDescendant<ContactGroupModel>(
            builder: (context, child, model) => RefreshIndicator(
                  onRefresh: model.refresh,
                  child: ListWidget(
                    onEmpty: Center(child: Text("No Contacts Found")),
                    items: model.contacts,
                    child: ListView.builder(
                      itemCount: model?.contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final _info = model.contacts[index];
                        if (index == model.contacts.length - 1)
                          model.fetchNext();
                        return ContactItem(model: contactModel, contact: _info);
                      },
                    ),
                  ),
                )),
        bottomNavigationBar: AppBottomBar(
          buttons: [
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) => AppSortButton(
                      sort: model.sort,
                      sortChanged: model.sortChanged,
                    )),
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) => AppRefreshButton(
                      isRefreshing: model.fetching,
                      onRefresh: model.refresh,
                    )),
//            IconButton(
//              tooltip: "Contact Tasks",
//              icon: Icon(Icons.event),
//              onPressed: () {
//                Navigator.pushNamed(context, "/contact_tasks");
//              },
//            ),
//            IconButton(
//              tooltip: "Contact Groups",
//              icon: Icon(Icons.group),
//              onPressed: () {
//                Navigator.pushNamed(context, "/contact_groups");
//              },
//            ),
          ],
        ),
//        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
//        floatingActionButton: SimpleFAB(
//          child: Icon(Icons.add),
//          onPressed: () => createContact(context, model: model),
//        ),
      ),
    );
  }
}

void viewGroup(BuildContext context,
    {@required ContactModel model, @required ContactGroup group}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ContactsFromGroupScreen(contactModel: model, group: group),
    ),
  );
}
