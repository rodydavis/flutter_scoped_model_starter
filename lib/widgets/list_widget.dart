import 'package:flutter/material.dart';

/// List Widget for Common Null, Empty and Items Widget
class ListWidget extends StatelessWidget {
  final List<dynamic> items;
  final Widget onNull, onEmpty, child;

  ListWidget({
    @required this.items,
    @required this.child,
    this.onEmpty,
    this.onNull,
  });

  @override
  Widget build(BuildContext context) {
    if (items == null) {
      return onNull ?? CircularProgressIndicator();
    }

    if (items.isEmpty) {
      return onEmpty ?? Text("No Items Found");
    }

    return child;
  }
}
