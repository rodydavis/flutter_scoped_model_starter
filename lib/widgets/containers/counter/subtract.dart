import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import '../../../data/models/counter.dart';

class CounterSubtractButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return FloatingActionButton(
      heroTag: "subtract",
      child: Icon(Icons.remove),
      onPressed: model.counter == 0 ? null : model.decrement,
    );
  }
}
