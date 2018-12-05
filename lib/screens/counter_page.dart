import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data/models/counter.dart';
import '../widgets/containers/counter/add.dart';
import '../widgets/containers/counter/subtract.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter Example"),
        leading: IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => Navigator.pushNamed(context, "/settings"),
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: new Text("Increment or Decrement"),
            leading: new Text(
              '${_model.counter}',
              style: Theme.of(context).textTheme.display1,
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonBar(
        children: <Widget>[
          CounterSubtractButton(),
          CounterAddButton(),
        ],
      ),
    );
  }
}
