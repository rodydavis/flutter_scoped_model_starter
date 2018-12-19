import 'package:flutter/material.dart';

import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/contacts/groups.dart';
import '../../../data/models/contacts/list.dart';
import 'edit.dart';
import 'item.dart';
import 'view.dart';
import '../../general/list_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../app/app_bottom_bar.dart';
import '../../app/app_refresh_button.dart';
import '../../general/simple_fab.dart';

class ContactGroupsScreen extends StatelessWidget {
  final ContactGroupModel groupModel;
  final ContactModel contactModel;

  ContactGroupsScreen({
    this.groupModel,
    @required this.contactModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactGroupModel>(
        model: groupModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Contact Groups"),
          ),
          body: new ScopedModelDescendant<ContactGroupModel>(
              builder: (context, child, model) => ListWidget(
                  items: model?.groups,
                  onEmpty: Center(
                    child: Text("No Groups Found"),
                  ),
                  child: RefreshIndicator(
                      onRefresh: model.refreshGroups,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: model?.groups?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _group = model?.groups[index];
                          return SafeArea(
                            child: WrapItem(
                              _group,
                              true,
                              index: index,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ContactsFromGroupScreen(
                                            contactModel: contactModel,
                                            group: _group),
                                  ),
                                );
                              },
//                          onLongPressed: () =>
//                              _editGroup(context, isNew: false, item: _group),
                            ),
                          );
                        },
                      )))),
          bottomNavigationBar: AppBottomBar(
            buttons: [
              new ScopedModelDescendant<ContactGroupModel>(
                  builder: (context, child, model) => AppRefreshButton(
                        isRefreshing: model.fetching,
                        onRefresh: model.refreshGroups,
                      )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.group_add),
            onPressed: () => null,
          ),
        ));
  }
}

class _ContactGroupsScreen extends StatefulWidget {
  final ContactGroupModel model;
  final ContactModel contactModel;

  _ContactGroupsScreen({
    this.model,
    @required this.contactModel,
  });

  @override
  ContactGroupsScreenState createState() {
    return new ContactGroupsScreenState();
  }
}

class ContactGroupsScreenState extends State<_ContactGroupsScreen> {
  List<ContactGroup> _groups;

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    if (!_isDisposed)
      setState(() {
        _groups = widget.model?.groups;
      });
    _loadInfo();
    super.initState();
  }

  void _editGroup(BuildContext context,
      {bool isNew = true, ContactGroup item}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactGroup(
                isNew: isNew,
                group: item,
                groupDeleted: () {
                  if (!_isDisposed)
                    setState(() {
                      _groups.clear();
                    });
                  widget.model.deleteContactGroup(id: item?.id);
                },
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        final ContactGroup _group = value;
        widget.model
            .editContactGroup(
          isNew: isNew,
          model: ContactGroup(name: _group?.name, id: _group?.id),
        )
            .then((_) {
          _loadInfo();
          // Navigator.pop(context, true);
        });
      }
    });
  }

  void _viewList(BuildContext context, {ContactGroup item}) {
//    Navigator.push(
//      context,
//      MaterialPageRoute(
//        builder: (context) => ContactGroupList(
//              model: widget.model,
//              contactModel: widget.contactModel,
//              group: item,
//              groupDeleted: () {
//                if (!_isDisposed)
//                  setState(() {
//                    _groups.clear();
//                  });
//                widget.model.deleteContactGroup(id: item?.id);
//              },
//            ),
//      ),
//    ).then((value) {
//      if (value != null) {
//        final ContactGroup _group = value;
//        widget.model
//            .editContactGroup(
//          isNew: false,
//          model: ContactGroup(name: _group?.name, id: _group?.id),
//        )
//            .then((_) {
//          _loadInfo();
//          // Navigator.pop(context, true);
//        });
//      }
//    });
  }

  void _loadInfo({bool force = false}) {
    if (force) {
      if (!_isDisposed)
        setState(() {
          _groups = null;
        });
    }

    widget.model.getGroups().then((_) {
      if (!_isDisposed)
        setState(() {
          _groups = widget.model?.groups ?? [];
          // _groups.sort((a, b) => b.count.compareTo(a.count));
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text("Contact Groups"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () => _loadInfo(),
        ),
        IconButton(
          icon: Icon(Icons.group_add),
          onPressed: () => _editGroup(context, isNew: true),
        ),
      ],
    );
    if (_groups == null || _groups.isEmpty) {
      if (_groups == null) {
        _loadInfo();
        return Scaffold(
          appBar: appBar,
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return Scaffold(
        appBar: appBar,
        body: Center(
          child: Text("No Groups Found"),
        ),
      );
    }
    return Scaffold(
      appBar: appBar,
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: widget.model?.groups?.length,
        itemBuilder: (BuildContext context, int index) {
          final _group = widget.model?.groups[index];
          return SafeArea(
            child: WrapItem(
              _group,
              true,
              index: index,
              onTap: () => _viewList(context, item: _group),
              onLongPressed: () =>
                  _editGroup(context, isNew: false, item: _group),
            ),
          );
        },
      ),
    );
  }
}
