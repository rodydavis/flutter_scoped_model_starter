import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../data/models/counter.dart';

class CounterAddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return FloatingActionButton(
      heroTag: "add",
      child: Icon(Icons.add),
      onPressed: model.increment,
    );
  }
}
