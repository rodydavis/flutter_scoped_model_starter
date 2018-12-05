import 'package:flutter/material.dart';

import '../../data/models/crud.dart';
import 'item/edit.dart';
import 'item/view.dart';

class CRUDItem extends StatelessWidget {
  final CRUDObject item;
  final CRUDModel model;
  CRUDItem({@required this.item, @required this.model});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item?.name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CRUDItemDetails(item: item, model: model)),
        );
      },
      onLongPress: () {
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
    );
  }
}
