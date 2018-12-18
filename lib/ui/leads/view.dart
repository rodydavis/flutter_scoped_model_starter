import 'package:flutter/material.dart';
import '../../data/models/lead_model.dart';
import '../../data/classes/leads/lead_row.dart';

class LeadDetailsScreen extends StatelessWidget {
  final LeadModel model;
  final LeadRow leadRow;

  LeadDetailsScreen({this.model, this.leadRow});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text(leadRow?.displayName),
          ),
          ListTile(
            title: Text(leadRow?.cellPhone),
          ),
          ListTile(
            title: Text(leadRow?.homePhone),
          ),
           ListTile(
            title: Text(leadRow?.officePhone),
          ),
        ],
      ),
    );
  }
}

void viewLead(BuildContext context,
    {@required LeadModel model, LeadRow leadRow}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LeadDetailsScreen(
              model: model,
              leadRow: leadRow,
            ),
        fullscreenDialog: false,
      ));
}
