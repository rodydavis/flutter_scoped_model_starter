import 'package:flutter/material.dart';

import '../../../data/models/crud_model.dart';
import '../../../ui/app/app_bottom_bar.dart';
import '../edit/crud_edit.dart';

class CRUDItemDetails extends StatefulWidget {
  final CRUDObject item;
  final bool showNameInAppBar;
  final CRUDModel model;
  CRUDItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
  });
  @override
  _CRUDItemDetailsState createState() => _CRUDItemDetailsState();
}

class _CRUDItemDetailsState extends State<CRUDItemDetails> {
  CRUDObject item;

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
            ? Text(item?.name ?? "Details")
            : Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(item?.name ?? ""),
            ),
            ListTile(
              title: Text(item?.description ?? ""),
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
        heroTag: "CRUD Edit",
        backgroundColor: Theme.of(context).primaryColorDark,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CRUDItemEdit(item: item),
                fullscreenDialog: true),
          ).then((value) {
            if (value != null) {
              CRUDObject _item = value;
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
