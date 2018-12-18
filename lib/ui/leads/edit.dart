import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/leads/list.dart';

class EditLeadScreen extends StatelessWidget {
  final LeadModel model;
  final bool isNew;

  EditLeadScreen({
    this.model,
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

void editLead(BuildContext context, {@required LeadModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditLeadScreen(model: model, isNew: false),
        fullscreenDialog: true,
      ));
}
