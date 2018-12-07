import 'package:flutter/material.dart';

import '../../data/models/contact_model.dart';
import '../../ui/app/app_bottom_bar.dart';
import 'edit.dart';

class ContactItemDetails extends StatefulWidget {
  final ContactObject item;
  final bool showNameInAppBar;
  final ContactModel model;
  ContactItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
  });
  @override
  _ContactItemDetailsState createState() => _ContactItemDetailsState();
}

class _ContactItemDetailsState extends State<ContactItemDetails> {
  ContactObject item;

  @override
  void initState() {
    _loadInfo();
    super.initState();
  }

  void _loadInfo() async {
    setState(() {
      item = widget.item;
    });
    // -- Load Info From API --
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.showNameInAppBar
            ? Text(item?.firstName ?? "Details")
            : Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // STARTER: details - do not remove comment
            ListTile(
              title: Text(item?.firstName ?? ""),
            ),
            ListTile(
              title: Text(item?.lastName ?? ""),
            ),
            ListTile(
              title: Text(item?.cellPhone ?? ""),
            ),
            ListTile(
              title: Text(item?.homePhone ?? ""),
            ),
            ListTile(
              title: Text(item?.officePhone ?? ""),
            ),
            ListTile(
              title: Text(item?.email ?? ""),
            ),
            ListTile(
              title: Text(item?.lastActivity ?? ""),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomBar(
        buttons: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.model.removeItem(item);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "Contact Edit",
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContactItemEdit(item: item),
                fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              ContactObject _item = value;
              widget.model.editItem(_item);
              Navigator.pop(context);
            }
          });
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        tooltip: 'Edit Item',
      ),
    );
  }
}
