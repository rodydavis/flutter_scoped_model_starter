import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/contact/fields.dart';
import '../../data/models/contact/list.dart';
import '../../data/models/contact/info.dart';
import '../../data/models/general/address.dart';
import '../../data/models/general/phones.dart';
import '../../data/models/contact/model.dart';

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
      _zip,
      _cellPhone,
      _officePhone,
      _homePhone;
  bool _isNew = false;
  bool _isLoaded = false;
  ContactDetails details;
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
    // -- Load Info --
    _firstName = TextEditingController(text: widget?.item?.firstName ?? "");
    _lastName = TextEditingController(text: widget?.item?.lastName ?? "");
    _email = TextEditingController(text: widget?.item?.email ?? "");
  }

  void _getDetails(BuildContext context, {ContactModel model}) async {
    var _contact = await model.getDetails(context, id: widget?.item?.id);
    setState(() {
      details = _contact;
      _isLoaded = true;
    });

    // -- Load from API --
    var _phones = details?.phones;
    for (var _phone in _phones) {
      if (_phone.label.contains("home")) {
        _homePhone = TextEditingController(text: _phone?.raw() ?? "");
      }
      if (_phone.label.contains("office")) {
        _officePhone = TextEditingController(text: _phone?.raw() ?? "");
      }
      if (_phone.label.contains("cell") || _phone.label.contains("mobile")) {
        _cellPhone = TextEditingController(text: _phone?.raw() ?? "");
      }
    }
    _middleName = TextEditingController(text: details?.middleName ?? "");
    _street = TextEditingController(text: details?.address?.street ?? "");
    _apartment = TextEditingController(text: details?.address?.apartment ?? "");
    _city = TextEditingController(text: details?.address?.city ?? "");
    _state = TextEditingController(text: details?.address?.state ?? "");
    _zip = TextEditingController(text: details?.address?.zip ?? "");
  }

  void _saveInfo(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      // final ContactObject _item = ContactObject(
      //   id: _isNew ? uuid.v4() : widget.item?.id,
      //   firstName: _firstName?.text ?? "",
      //   lastName: _lastName?.text ?? "",
      // );

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
        phones: [
          Phones.fromString(_cellPhone?.text ?? "", name: "cell"),
          Phones.fromString(_homePhone?.text ?? "", name: "home"),
          Phones.fromString(_officePhone?.text ?? "", name: "office"),
        ],
      );

      Navigator.pop(context, _contact);
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final _model = ScopedModel.of<ContactModel>(context, rebuildOnChange: true);
    final _model = widget.model;
    if (details == null) _getDetails(context, model: _model);
    final String _type = ContactFields.objectType;
    return Scaffold(
      appBar: AppBar(
        title: _isNew ? Text("New $_type") : Text("Edit $_type"),
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
              ExpansionTile(
                title: Text("Phones"),
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Cell Phone"),
                      controller: _cellPhone,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Office Phone"),
                      controller: _officePhone,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Home Phone"),
                      controller: _homePhone,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Container(height: 5.0),
                ],
              ),
              ExpansionTile(
                title: Text("Address"),
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Street"),
                      controller: _street,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Apartment"),
                      controller: _apartment,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "City"),
                      controller: _city,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "State"),
                      controller: _state,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      decoration: InputDecoration(labelText: "Zip"),
                      controller: _zip,
                      keyboardType: TextInputType.text,
                    ),
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
