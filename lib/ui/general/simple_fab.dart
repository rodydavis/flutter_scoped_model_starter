import 'package:flutter/material.dart';

class SimpleFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  SimpleFAB({this.child, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FloatingActionButton(
        child: child ?? Icon(Icons.add),
        onPressed: onPressed,
      ),
    );
  }
}
