import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData iconData;

  ActionButton({this.onPressed, this.label, this.iconData});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 6.0),
          child: IconButton(
            iconSize: 50.0,
            icon: Icon(
              iconData ?? Icons.add_circle_outline,
              color: onPressed == null ? null : Colors.blue,
            ),
            onPressed: onPressed,
          ),
        ),
        Container(
          child: Text(
            label ?? "Action",
            style:
                Theme.of(context).textTheme.display1.copyWith(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
