import 'package:flutter/material.dart';

import '../../data/models/contact_model.dart';
import 'item.dart';

ScrollView buildList({
  @required ContactModel model,
  bool isSearching = false,
}) {
  if (isSearching) {
    return ListView.builder(
      itemCount: model?.filteredItems?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final _item = model?.filteredItems[index];
        return ContactItem(
          item: _item,
          model: model,
        );
      },
    );
  }
  return ListView.builder(
    itemCount: model?.items?.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      final _item = model?.items[index];
      return ContactItem(
        item: _item,
        model: model,
      );
    },
  );
}
