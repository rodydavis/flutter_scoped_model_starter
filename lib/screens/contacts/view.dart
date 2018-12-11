import 'package:flutter/material.dart';

import '../../data/models/contact/list.dart';
import '../../data/models/contact/model.dart';
import '../../ui/app/app_bottom_bar.dart';
import '../../ui/containers/email_tile.dart';
import '../../ui/containers/phone_tile.dart';
import 'edit.dart';

class ContactItemDetails extends StatefulWidget {
  final ContactObject item;
  final String name;
  final bool showNameInAppBar;
  final ContactModel model;
  ContactItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
    this.name = "",
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
              leading: Icon(Icons.person),
              title: Text(
                (item?.firstName ?? "" + " " + (item?.lastName ?? "")),
              ),
              subtitle: Text(item?.lastActivity ?? ""),
            ),
            buildPhoneTile(context,
                label: "Cell Phone",
                number: item?.cellPhone,
                icon: Icons.phone),
            buildPhoneTile(context,
                label: "Home Phone", number: item?.homePhone, icon: Icons.home),
            buildPhoneTile(context,
                label: "Office Phone",
                number: item?.officePhone,
                icon: Icons.work),
            buildEmailTile(context, label: "Email Address", email: item?.email),
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
