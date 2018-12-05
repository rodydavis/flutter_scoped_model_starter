import 'package:flutter/material.dart';

import '../../../data/models/crud.dart';
import '../../../widgets/components/app_bar/bottom.dart';
import 'package:scoped_model/scoped_model.dart';
import 'edit.dart';

class CRUDItemDetails extends StatelessWidget {
  final CRUDObject item;
  final bool showNameInAppBar;
  final CRUDModel model;
  CRUDItemDetails({
    @required this.item,
    this.showNameInAppBar = true,
    @required this.model,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            showNameInAppBar ? Text(item?.name ?? "Details") : Text("Details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(item?.name),
            )
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
              model.removeItem(item);
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
              model.editItem(_item);
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
