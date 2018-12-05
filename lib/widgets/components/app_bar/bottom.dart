import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final List<IconButton> buttons;
  AppBottomBar({@required this.buttons});
  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(children: buttons),
    );
  }
}
