
import 'package:flutter/material.dart';

import '../../../data/classes/unify/contact_group.dart';

class WrapItem extends StatelessWidget {
  const WrapItem(
    this.item,
    this.isSource, {
    this.index = 0,
    this.onTap,
    this.onLongPressed,
  }) : size = isSource ? 40.0 : 50.0;
  final bool isSource;
  final double size;
  final int index;
  final ContactGroup item;
  final VoidCallback onTap, onLongPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => SidekickTeamBuilder.of<Item>(context).move(item),
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size - 4,
          width: size - 4,
          decoration: new BoxDecoration(
              color: item?.count == 0
                  ? Colors.grey
                  : Theme.of(context).primaryColor,
              borderRadius: new BorderRadius.all(const Radius.circular(60.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(item?.name ?? "No Name Found",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white)),
              Text(item?.count.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  // Color _getColor(int index) {
  //   switch (index % 4) {
  //     // case 0:
  //     //   return Colors.blueGrey;
  //     // case 1:
  //     //   return Colors.red;
  //     // case 2:
  //     //   return Colors.purple;
  //     // case 3:
  //     //   return Colors.green;
  //   }
  //   return Colors.blueGrey;
  // }
}
