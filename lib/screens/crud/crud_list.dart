import 'package:flutter/material.dart';

import '../../data/models/crud_model.dart';
import 'crud_item.dart';

class CRUDList extends StatelessWidget {
  final CRUDModel model;
  CRUDList({@required this.model});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: model?.items?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final _item = model?.items[index];
        return CRUDItem(
          item: _item,
          model: model,
          // edit: false,
          // share: false,
          // delete: false,
        );
      },
    );
  }
}
