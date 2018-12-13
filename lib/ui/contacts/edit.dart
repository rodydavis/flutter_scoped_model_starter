import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

import '../../data/classes/contacts/contact_details.dart';
import '../../data/classes/contacts/contact_row.dart';
import '../../data/classes/general/address.dart';
import '../../data/classes/general/phone.dart';
import '../../data/models/contact_model.dart';
import '../general/address_tile.dart';
import '../general/phone_tile.dart';

class ContactItemEdit extends StatefulWidget {
  final ContactRow item;
  final ContactModel model;
  final ContactDetails details;
  ContactItemEdit({this.item, @required this.model, this.details});
  @override
  _ContactItemEditState createState() =>
      _ContactItemEditState(details: details);
}

class _ContactItemEditState extends State<ContactItemEdit> {
  _ContactItemEditState({this.details});

  TextEditingController _firstName, _middleName, _lastName, _email;
  bool _isNew = false;

  ContactDetails details;

  Phone _cell, _home, _office;
  // Address _address;

  Address get address => details?.address;

  @override
  void initState() {
    // _updateView(contactDetails: widget.details);
    _loadItemDetails();
    super.initState();
  }

  void _loadItemDetails() async {
    if ((widget?.item?.id ?? "").toString().isEmpty) {
      setState(() {
        _isNew = true;
      });
    }
    print("Passed => " + details?.toJson().toString());
    _updateView(contactDetails: details);
  }

  void _getDetails(BuildContext context, {ContactModel model}) async {
    var _contact = await model.getDetails(context, id: widget?.item?.id);
    setState(() {
      details = _contact;
    });
    _updateView(contactDetails: _contact);
  }

  void _saveInfo(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      var _phones = <Phone>[];
      if (_cell != null && _cell.raw().isNotEmpty) _phones.add(_cell);
      if (_home != null && _home.raw().isNotEmpty) _phones.add(_home);
      if (_office != null && _office.raw().isNotEmpty) _phones.add(_office);
      // setState(() {
      //   _address = details?.address;
      // });
      print("Address => " + address?.raw());

      ContactDetails _contact = ContactDetails(
        firstName: _firstName?.text ?? "",
        middleName: _middleName?.text ?? "",
        lastName: _lastName?.text ?? "",
        email: _email?.text ?? "",
        address: address,
        phones: _phones,
      );

      print(_contact.toJson());

      // Navigator.pop(context, _contact);
    }
  }

  final _formKey = GlobalKey<FormState>();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void showInSnackBar(Widget child) {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(content: child));
  }

  void _updateView({Contact phoneContact, ContactDetails contactDetails}) {
    if (phoneContact == null || details == null) {
      _firstName = TextEditingController(text: widget?.item?.firstName ?? "");
      _lastName = TextEditingController(text: widget?.item?.lastName ?? "");
      _email = TextEditingController(text: widget?.item?.email ?? "");

      setState(() {
        _cell = Phone.fromString(widget?.item?.cellPhone ?? "");
        _home = Phone.fromString(widget?.item?.homePhone ?? "");
        _office = Phone.fromString(widget?.item?.officePhone ?? "");
      });
    } else {
      if (phoneContact != null) {
        setState(() {
          details = ContactDetails.fromPhoneContact(phoneContact);
          print(details.toJson().toString());
        });
      }
      if (contactDetails != null) {
        setState(() {
          details = contactDetails;
        });
      }

      // -- Load Info from Phone Contact --
      _firstName = TextEditingController(text: details?.firstName ?? "");
      _middleName = TextEditingController(text: details?.middleName ?? "");
      _lastName = TextEditingController(text: details?.lastName ?? "");
      _email = TextEditingController(text: details?.email ?? "");

      var _phones = details?.phones ?? [];
      for (var _phone in _phones) {
        if (_phone.label.contains("home")) {
          setState(() {
            _home = _phone;
          });
        }
        if (_phone.label.contains("office")) {
          setState(() {
            _office = _phone;
          });
        }
        if (_phone.label.contains("cell") || _phone.label.contains("mobile")) {
          setState(() {
            _cell = _phone;
          });
        }
      }

      _middleName = TextEditingController(text: details?.middleName ?? "");
    }

    // setState(() {
    //   _formKey.currentState.validate();
    // });
  }

  @override
  Widget build(BuildContext context) {
    // final _model = ScopedModel.of<ContactModel>(context, rebuildOnChange: true);
    final _model = widget.model;
    if (details == null) _getDetails(context, model: _model);
    final String _type = ContactFields.objectType;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: _isNew ? Text("New $_type") : Text("Edit $_type"),
        actions: <Widget>[
          IconButton(
            tooltip: "Import Contact",
            icon: Icon(Icons.import_contacts),
            onPressed: () =>
                Navigator.pushNamed(context, "/import_single").then((value) {
                  if (value != null) _updateView(phoneContact: value);
                }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              ListTile(
                title: TextFormField(
                  autofocus: true,
                  decoration:
                      InputDecoration(labelText: ContactFields.first_name),
                  controller: _firstName,
                  keyboardType: TextInputType.text,
                  validator: (val) => val.isEmpty
                      ? 'Please enter a ${ContactFields.first_name}'
                      : null,
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Middle Name"),
                  controller: _middleName,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration:
                      InputDecoration(labelText: ContactFields.last_name),
                  controller: _lastName,
                  keyboardType: TextInputType.text,
                  validator: (val) => val.isEmpty
                      ? 'Please enter a ${ContactFields.last_name}'
                      : null,
                ),
              ),
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: ContactFields.email),
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              ExpansionTile(
                title: Text("Phone"),
                children: <Widget>[
                  PhoneInputTile(
                    label: "Cell Phone",
                    number: _cell,
                    numberChanged: (Phone value) {
                      setState(() {
                        _cell = value;
                      });
                    },
                  ),
                  PhoneInputTile(
                    label: "Home Phone",
                    number: _home,
                    numberChanged: (Phone value) {
                      setState(() {
                        _home = value;
                      });
                    },
                  ),
                  PhoneInputTile(
                    showExt: true,
                    label: "Office Phone",
                    number: _office,
                    numberChanged: (Phone value) {
                      setState(() {
                        _office = value;
                      });
                    },
                  ),
                  Container(height: 5.0),
                ],
              ),
              ExpansionTile(
                title: Text("Address"),
                children: <Widget>[
                  AddressInputTile(
                    label: "Current Address",
                    address: details?.address,
                    addressChanged: (Address value) {
                      setState(() {
                        details.address = value;
                      });
                    },
                  ),
                  Container(height: 5.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      _isNew ? "Add $_type" : "Save $_type",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () => _saveInfo(context),
                  ),
                ],
              ),
              Container(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}
