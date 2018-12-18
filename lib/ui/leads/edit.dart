import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/leads/list.dart';
import '../../data/classes/leads/lead_details.dart';

class EditLeadScreen extends StatelessWidget {
  final LeadModel model;
  final LeadDetails details;
  final bool isNew;

  EditLeadScreen({
    this.model,
    this.details,
    this.isNew = true,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadModel>(
        model: model,
        child: Scaffold(
          appBar: AppBar(
            title: isNew ? const Text("New Lead") : const Text("Edit Lead"),
          ),
          body: Container(),
        ));
  }
}

void createLead(BuildContext context, {@required LeadModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditLeadScreen(model: model),
        fullscreenDialog: true,
      ));
}

void editLead(BuildContext context,
    {@required LeadModel model, LeadDetails details}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) =>
            new EditLeadScreen(model: model, isNew: false, details: details),
        fullscreenDialog: true,
      ));
}
