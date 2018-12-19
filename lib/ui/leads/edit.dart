import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/leads/list.dart';
import '../../data/classes/leads/lead_details.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';
import '../phone_contacts/import.dart';
import '../app/app_input_field.dart';

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

  @override
  void initState() {
    _init();
    if (!widget.isNew) {
      if (widget.leadRow != null) _loadRow();
      if (widget.details != null) _loadDetails();
    }
    super.initState();
  }

  void _loadDetails() {
    _updateView(widget.details);
  }

  void _loadRow() {
    _updateView(LeadDetails(
      firstName: widget.leadRow?.firstName,
      lastName: widget.leadRow?.lastName,
      email: widget.leadRow?.email,
    ));
  }

  void _init() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
  }

  void _updateView(LeadDetails newLead) {
    _init();

    setState(() {
      _firstName.text = newLead?.firstName ?? "";
      _lastName.text = newLead?.lastName ?? "";
      _email.text = newLead?.email ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadDetailsModel>(
        model: widget.model,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:
                widget.isNew ? const Text("New Lead") : const Text("Edit Lead"),
            actions: <Widget>[
              IconButton(
                tooltip: "Import Phone Contact",
                icon: Icon(Icons.import_contacts),
                onPressed: () => selectContact(context).then((contact) {
                      print("Item: " + contact.toString());
                      if (contact != null) {
                        var _lead = LeadDetails.fromPhoneContact(contact);
                        print("Lead => " + _lead.toJson().toString());
                        _updateView(_lead);
                      }
                    }),
              ),
              IconButton(
                tooltip: "Lead Groups",
                icon: Icon(Icons.group),
//                onPressed: () =>
//                    _manageContactGroups(context, model: widget.model),
                onPressed: null,
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  AppInputField(
                    name: LeadFields.first_name,
                    autoFocus: true,
                    required: true,
                    controller: _firstName,
                  ),
                  AppInputField(
                    name: LeadFields.last_name,
                    required: true,
                    controller: _lastName,
                  ),
                  AppInputField(
                    name: LeadFields.email,
                    controller: _email,
                  ),
                  Container(height: 10.0),
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
                                        var _newLead = getLeadFromInputs();
                                        if (_newLead != null) {
                                          if (widget.isNew) {
                                            await model.add(_newLead);
                                          } else {
                                            await model.edit(_newLead);
                                          }

                                          if (model.fetching == false &&
                                              (model?.error?.isEmpty ??
                                                  false)) {
                                            Navigator.pop(context, true);
                                          }
                                        }
                                      },
                                    ),
                            ],
                          )),
                  new ScopedModelDescendant<LeadDetailsModel>(
                      rebuildOnChange: true,
                      builder: (context, child, model) =>
                          model.fetching == false &&
                                  (model?.error?.isNotEmpty ?? false)
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

  LeadDetails getLeadFromInputs() {
    if (_formKey.currentState.validate()) {
      final _newLead = LeadDetails(
        firstName: _firstName.text ?? "",
        lastName: _lastName.text ?? "",
        email: _email.text ?? "",
      );

      return _newLead;
    }
    return null;
  }
}

void createLead(BuildContext context, {@required LeadModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditLeadScreen(
              model: LeadDetailsModel(auth: model?.auth),
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
            model: LeadDetailsModel(auth: model?.auth, id: leadRow?.id),
            isNew: false,
            details: details,
            leadRow: leadRow),
        fullscreenDialog: true,
      ));
}
