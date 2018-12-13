import 'package:flutter/material.dart';

import '../../data/models/contact_model.dart';
import 'item.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';

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
          // edit: false,
          // share: false,
          // delete: false,
        );
      },
    );
  }
  // return new SmartRefresher(
  //     enablePullDown: true,
  //     enablePullUp: true,
  //     controller: controller,
  //     onRefresh: (up) => up ? onRefresh : onReachEnd,
  //     onOffsetChange: (bool isUp, double offset) {
  //       if (isUp) {
  //         onOffsetChangeUp(offset);
  //       } else {
  //         onOffsetChangeEnd(offset);
  //       }
  //     },
  //     child:
  return ListView.builder(
    itemCount: model?.items?.length ?? 0,
    itemBuilder: (BuildContext context, int index) {
      final _item = model?.items[index];
      return ContactItem(
        item: _item,
        model: model,
        // edit: false,
        // share: false,
        // delete: false,
      );
    },
  );
}
