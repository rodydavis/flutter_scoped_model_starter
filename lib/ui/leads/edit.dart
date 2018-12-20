import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/leads/lead_details.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';
import '../../data/models/leads/list.dart';
import '../app/app_input_field.dart';
import '../phone_contacts/import.dart';
import '../general/phone_tile.dart';
import '../../data/classes/general/phone.dart';
import '../../data/classes/general/address.dart';
import '../general/address_tile.dart';

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
  Phone cellPhone, homePhone, officePhone;
  Address currentAddress, propertyAddress;

  @override
  void initState() {
    _init();
    if (!widget.isNew) {
      if (widget.leadRow != null) _row(widget.leadRow);
      if (widget.details != null) _loadDetails();
    }
    super.initState();
  }

  void _loadDetails() {
    _updateView(widget.details);
  }

  void _row(LeadRow row) {
    _updateView(LeadDetails(
      firstName: row?.firstName,
      lastName: row?.lastName,
      email: row?.email,
    ));
  }

  void _init() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();

    currentAddress = null;
    propertyAddress = null;
    cellPhone = null;
    homePhone = null;
    officePhone = null;
  }

  void _updateView(LeadDetails info) {
    _init();

    setState(() {
      _firstName.text = info?.firstName ?? "";
      _lastName.text = info?.lastName ?? "";
      _email.text = info?.email ?? "";

      currentAddress = info?.currentAddress;
      propertyAddress = info?.propertyAddress;
      cellPhone = info?.cellPhone;
      homePhone = info?.homePhone;
      officePhone = info?.officePhone;
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
                onPressed: () => selectSingleContact(context).then((contact) {
                      print("Item: " + contact.toString());
                      if (contact != null) {
                        var _info = LeadDetails.fromPhoneContact(contact);
                        print("Lead => " + _info.toJson().toString());
                        _updateView(_info);
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
                  ExpansionTile(
                    title: Text("Phone Numbers"),
                    children: <Widget>[
                      PhoneInputTile(
                        label: "Cell Phone",
                        numberChanged: (Phone value) {
                          setState(() {
                            cellPhone = value;
                          });
                        },
                        number: cellPhone,
                      ),
                      PhoneInputTile(
                        label: "Home Phone",
                        numberChanged: (Phone value) {
                          setState(() {
                            homePhone = value;
                          });
                        },
                        number: homePhone,
                      ),
                      PhoneInputTile(
                        label: "Office Phone",
                        showExt: true,
                        numberChanged: (Phone value) {
                          setState(() {
                            officePhone = value;
                          });
                        },
                        number: officePhone,
                      ),
                    ],
                  ),
                  ExpansionTile(
                    title: Text("Address Info"),
                    children: <Widget>[
                      AddressInputTile(
                        label: "Current Address",
                        addressChanged: (Address value) {
                          setState(() {
                            currentAddress = value;
                          });
                        },
                        address: currentAddress,
                      ),
                      AddressInputTile(
                        label: "Property Address",
                        addressChanged: (Address value) {
                          setState(() {
                            propertyAddress = value;
                          });
                        },
                        address: propertyAddress,
                      ),
                    ],
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
                                        var _info = getInfoFromInputs();
                                        if (_info != null) {
                                          if (widget.isNew) {
                                            await model.add(_info);
                                          } else {
                                            await model.edit(_info);
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

  LeadDetails getInfoFromInputs() {
    if (_formKey.currentState.validate()) {
      final _info = LeadDetails(
        firstName: _firstName.text ?? "",
        lastName: _lastName.text ?? "",
        email: _email.text ?? "",
      );

      return _info;
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
