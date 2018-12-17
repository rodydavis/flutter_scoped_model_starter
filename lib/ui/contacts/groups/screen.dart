import 'package:flutter/material.dart';

import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/contact_model.dart';
import 'edit.dart';
import 'item.dart';
import 'view.dart';

class ContactGroupsScreen extends StatefulWidget {
  final ContactModel model;
  final AuthModel auth;

  ContactGroupsScreen({
    this.model,
    @required this.auth,
  });

  @override
  ContactGroupsScreenState createState() {
    return new ContactGroupsScreenState();
  }
}

class ContactGroupsScreenState extends State<ContactGroupsScreen> {
  List<ContactGroup> _groups;

  @override
  void initState() {
    setState(() {
      _groups = widget.model?.groups;
    });
    super.initState();
  }

  void _editGroup(BuildContext context,
      {bool isNew = true, ContactGroup item}) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditContactGroup(
                isNew: isNew,
                groupName: item?.name,
                id: item?.id,
                groupDeleted: () {
                  setState(() {
                    _groups.clear();
                  });
                  widget.model.deleteContactGroup(
                    context,
                    id: item?.id,
                    auth: widget.auth,
                  );
                },
              ),
          fullscreenDialog: true),
    ).then((value) {
      if (value != null) {
        final ContactGroup _group = value;
        widget.model
            .editContactGroup(
          context,
          auth: widget.auth,
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ContactGroupList(
              auth: widget.auth,
              model: widget.model,
              groupName: item?.name,
              id: item?.id,
              groupDeleted: () {
                setState(() {
                  _groups.clear();
                });
                widget.model.deleteContactGroup(
                  context,
                  id: item?.id,
                  auth: widget.auth,
                );
              },
            ),
      ),
    ).then((value) {
      if (value != null) {
        final ContactGroup _group = value;
        widget.model
            .editContactGroup(
          context,
          auth: widget.auth,
          isNew: false,
          model: ContactGroup(name: _group?.name, id: _group?.id),
        )
            .then((_) {
          _loadInfo();
          // Navigator.pop(context, true);
        });
      }
    });
  }

  void _loadInfo() {
    setState(() {
      _groups = null;
    });
    widget.model
        .loadContactGroups(
      context,
      auth: widget.auth,
    )
        .then((_) {
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
