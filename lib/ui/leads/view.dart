import 'package:flutter/material.dart';

import '../../data/classes/leads/lead_row.dart';
import '../../data/models/lead_model.dart';
import '../app/app_bottom_bar.dart';
import 'edit.dart';

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
      bottomNavigationBar: AppBottomBar(
        // showSort: false,
        buttons: [
          IconButton(
            tooltip: "Delete Lead",
            icon: Icon(Icons.delete),
            // onPressed: () {
            //   //Todo: Ask for Confirmation
            //   widget.model.deleteItem(context, id: item?.id);
            //   Navigator.pop(context);
            // },
            onPressed: null,
          ),
          IconButton(
            tooltip: "Lead Groups",
            icon: Icon(Icons.people),
            onPressed: () => null,
          ),
          IconButton(
            tooltip: "Add Follow Up",
            icon: Icon(Icons.event_available),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Add Note",
            icon: Icon(Icons.note_add),
            onPressed: null,
          ),
          IconButton(
            tooltip: "Add Log Response",
            icon: Icon(Icons.timer),
            onPressed: null,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        heroTag: "Lead Edit",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => editLead(context, model: model),
        child: Icon(Icons.edit, color: Colors.white),
        tooltip: 'Edit Item',
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
