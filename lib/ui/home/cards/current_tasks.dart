import 'package:flutter/material.dart';

class CurrentTasksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Tap..");
        Navigator.of(context).pushNamed("/all_tasks");
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "No Tasks For Today",
                style: Theme.of(context).textTheme.display1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
