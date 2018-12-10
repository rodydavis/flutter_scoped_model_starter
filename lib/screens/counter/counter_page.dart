import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/counter.dart';
import '../../ui/app/app_drawer.dart';
import '../../widgets/counter/add.dart';
import '../../widgets/counter/subtract.dart';

class CounterPage extends StatelessWidget {
  final CounterModel model;
  CounterPage({@required this.model});
  @override
  Widget build(BuildContext context) {
    return new ScopedModel<CounterModel>(
      model: model,
      child: _CounterPage(),
    );
  }
}

class _CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return Scaffold(
      appBar: AppBar(
        title: Text("Counter"),
      ),
       drawer: AppDrawer(),
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
