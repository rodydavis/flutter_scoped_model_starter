import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/leads/list.dart';
import '../../data/classes/leads/lead_details.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';

class EditLeadScreen extends StatefulWidget {
  final LeadDetailsModel model;
  final LeadDetails details;
  final LeadRow leadRow;
  final bool isNew;

  EditLeadScreen({
    this.model,
    this.details,
    this.isNew = true,
    this.leadRow,
  });

  @override
  EditLeadScreenState createState() {
    return new EditLeadScreenState();
  }
}

class EditLeadScreenState extends State<EditLeadScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName, _lastName, _email;
  LeadDetails lead;

  @override
  void initState() {
    if (!widget.isNew) {
      if (widget.leadRow != null) _loadRow();
      if (widget.details != null) _loadDetails();
    }
    _updateView();
    super.initState();
  }

  void _loadDetails() {
    setState(() {
      lead = widget.details;
    });
  }

  void _loadRow() {
    setState(() {
      lead = LeadDetails(
        firstName: widget.leadRow?.firstName,
        lastName: widget.leadRow?.lastName,
        email: widget.leadRow?.email,
      );
    });
  }

  void _updateView() {
    _firstName = TextEditingController(text: lead?.firstName ?? "");
    _lastName = TextEditingController(text: lead?.lastName ?? "");
    _email = TextEditingController(text: lead?.email ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadDetailsModel>(
        model: widget.model,
        child: Scaffold(
          appBar: AppBar(
            title:
                widget.isNew ? const Text("New Lead") : const Text("Edit Lead"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              onChanged: _onFormChange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      controller: _firstName,
                      autofocus: true,
                      decoration:
                          InputDecoration(labelText: LeadFields.first_name),
                      keyboardType: TextInputType.text,
                      validator: (val) => val.isEmpty
                          ? 'Please enter a ${LeadFields.first_name}'
                          : null,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: _lastName,
                      decoration:
                          InputDecoration(labelText: LeadFields.last_name),
                      keyboardType: TextInputType.text,
                      validator: (val) => val.isEmpty
                          ? 'Please enter a ${LeadFields.last_name}'
                          : null,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: _email,
                      decoration: InputDecoration(labelText: LeadFields.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val != null && val.isNotEmpty && !val.contains("@")
                              ? 'Please enter a valid ${LeadFields.email}'
                              : null,
                    ),
                  ),
                  new ScopedModelDescendant<LeadDetailsModel>(
                      builder: (context, child, model) => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              model.fetching
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : RaisedButton(
                                      color: Colors.blue,
                                      child: Text(
                                        widget.isNew ? "Add Lead" : "Save Lead",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          print("Saving Info...");
                                          print(lead?.toJson());

                                          if (widget.isNew) {
                                            await model.add(lead);
                                          } else {
                                            await model.edit(lead);
                                          }
                                          if (model.error.isEmpty)
                                            Navigator.pop(context, true);
                                        }
                                      },
                                    ),
                            ],
                          )),
                  new ScopedModelDescendant<LeadDetailsModel>(
                      rebuildOnChange: true,
                      builder: (context, child, model) =>
                          model?.error?.isNotEmpty ?? false
                              ? Text(
                                  model.error,
                                  maxLines: null,
                                  style: TextStyle(color: Colors.red),
                                )
                              : Container()),
                  Container(height: 50.0),
                ],
              ),
            ),
          ),
        ));
  }

  void _onFormChange() {
    final _newLead = LeadDetails(
      firstName: _firstName.text ?? "",
      lastName: _lastName.text ?? "",
      email: _email.text ?? "",
    );
    setState(() {
      lead = _newLead;
    });
  }
}

void createLead(BuildContext context, {@required LeadModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditLeadScreen(
              model: LeadDetailsModel(authModel: model?.auth),
            ),
        fullscreenDialog: true,
      ));
}

void editLead(BuildContext context,
    {@required LeadModel model,
    LeadDetails details,
    @required LeadRow leadRow}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditLeadScreen(
              model: LeadDetailsModel(authModel: model?.auth, id: leadRow?.id),
              isNew: false,
              details: details,
              leadRow: leadRow,
            ),
        fullscreenDialog: true,
      ));
}
