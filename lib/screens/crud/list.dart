import 'package:flutter/material.dart';

import '../../data/models/crud_model.dart';
import 'item.dart';

class CRUDList extends StatelessWidget {
  final CRUDModel model;
  final bool isSearching;

  CRUDList({
    @required this.model,
    this.isSearching = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isSearching) {
      return ListView.builder(
        itemCount: model?.filteredItems?.length ?? 0,
        itemBuilder: (BuildContext context, int index) {
          final _item = model?.filteredItems[index];
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
