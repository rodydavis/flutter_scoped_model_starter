import 'package:flutter/material.dart';

class AppBottomBar extends StatelessWidget {
  final List<Widget> buttons;
  AppBottomBar({this.buttons});

  @override
  Widget build(BuildContext context) {
    return new Container(
//      height: 48.0,
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child:
            buttons == null ? Container(height: 25.0) : Row(children: buttons),
      ),
    );
  }
}
