import 'package:flutter/material.dart';
import '../../general/action_button.dart';

class ActionsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _actions = <Widget>[
      ActionButton(
        label: "Create Contact",
        onPressed: () => Navigator.pushNamed(context, "/create_contact"),
      ),
      ActionButton(
        label: "Create Lead",
        onPressed: () => Navigator.pushNamed(context, "/create_lead"),
      ),
      ActionButton(
        label: "Contact Groups",
        iconData: Icons.group,
        onPressed: () => Navigator.pushNamed(context, "/contact_groups"),
      ),
      ActionButton(
        label: "Lead Groups",
        iconData: Icons.group,
        onPressed: () => Navigator.pushNamed(context, "/lead_groups"),
      ),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: _actions,
        ),
      ),
    );
  }
}
