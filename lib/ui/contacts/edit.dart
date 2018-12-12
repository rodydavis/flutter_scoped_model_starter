import 'package:flutter/material.dart';

import '../../data/models/contact/fields.dart';
import '../../data/models/contact/list.dart';
import '../../data/models/contact/info.dart';
import '../../data/models/general/address.dart';
import '../../data/models/general/phones.dart';
import '../../data/models/contact/model.dart';
import 'package:contacts_service/contacts_service.dart';
import '../general/phone_tile.dart';
import '../general/address_tile.dart';

class ContactItemEdit extends StatefulWidget {
  final ContactObject item;
  final ContactModel model;
  ContactItemEdit({this.item, @required this.model});
  @override
  _ContactItemEditState createState() => _ContactItemEditState();
}

class _ContactItemEditState extends State<ContactItemEdit> {
  TextEditingController _firstName,
      _middleName,
      _lastName,
      _email,
      _street,
      _apartment,
      _city,
      _state,
      _zip;
  bool _isNew = false;

  ContactDetails details;

  Phones _cell, _home, _office;
  Address _address;

  @override
  void initState() {
    _loadItemDetails();
    super.initState();
  }

  void _loadItemDetails() async {
    if ((widget?.item?.id ?? "").toString().isEmpty) {
      setState(() {
        _isNew = true;
      });
    }
    _updateView();
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
      ContactDetails _contact = ContactDetails(
        firstName: _firstName?.text ?? "",
        middleName: _middleName?.text ?? "",
        lastName: _lastName?.text ?? "",
        email: _email?.text ?? "",
        address: Address(
          street: _street?.text ?? "",
          apartment: _apartment?.text ?? "",
          city: _city?.text ?? "",
          state: _state?.text ?? "",
          zip: _zip?.text ?? "",
        ),
        phones: [_cell, _home, _office],
      );

      Navigator.pop(context, _contact);
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
        _cell = Phones.fromString(widget?.item?.cellPhone ?? "");
        _home = Phones.fromString(widget?.item?.homePhone ?? "");
        _office = Phones.fromString(widget?.item?.officePhone ?? "");
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
      _street = TextEditingController(text: details?.address?.street ?? "");
      _apartment =
          TextEditingController(text: details?.address?.apartment ?? "");
      _city = TextEditingController(text: details?.address?.city ?? "");
      _state = TextEditingController(text: details?.address?.state ?? "");
      _zip = TextEditingController(text: details?.address?.zip ?? "");
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
                title: Text("Phones"),
                children: <Widget>[
                  PhoneInputTile(
                    label: "Cell Phone",
                    number: _cell,
                    numberChanged: (Phones value) {
                      setState(() {
                        _cell = value;
                      });
                    },
                  ),
                  PhoneInputTile(
                    label: "Home Phone",
                    number: _home,
                    numberChanged: (Phones value) {
                      setState(() {
                        _home = value;
                      });
                    },
                  ),
                  PhoneInputTile(
                    showExt: true,
                    label: "Office Phone",
                    number: _office,
                    numberChanged: (Phones value) {
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
                    address: _address,
                    addressChanged: (Address value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                  // ListTile(
                  //   title: TextFormField(
                  //     decoration: InputDecoration(labelText: "Street"),
                  //     controller: _street,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: TextFormField(
                  //     decoration: InputDecoration(labelText: "Apartment"),
                  //     controller: _apartment,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: TextFormField(
                  //     decoration: InputDecoration(labelText: "City"),
                  //     controller: _city,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: TextFormField(
                  //     decoration: InputDecoration(labelText: "State"),
                  //     controller: _state,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
                  // ListTile(
                  //   title: TextFormField(
                  //     decoration: InputDecoration(labelText: "Zip"),
                  //     controller: _zip,
                  //     keyboardType: TextInputType.text,
                  //   ),
                  // ),
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
