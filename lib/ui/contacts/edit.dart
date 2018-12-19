import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/contacts/contact_details.dart';
import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/details.dart';
import '../../data/models/contacts/list.dart';
import '../app/app_input_field.dart';
import '../phone_contacts/import.dart';

class EditContactScreen extends StatefulWidget {
  final ContactDetailsModel model;
  final ContactDetails details;
  final ContactRow contactRow;
  final bool isNew;

  EditContactScreen({
    this.model,
    this.details,
    this.isNew = true,
    this.contactRow,
  });

  @override
  EditContactScreenState createState() {
    return new EditContactScreenState();
  }
}

class EditContactScreenState extends State<EditContactScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _firstName, _lastName, _email;

  @override
  void initState() {
    _init();
    if (!widget.isNew) {
      if (widget.contactRow != null) _row(widget.contactRow);
      if (widget.details != null) _loadDetails();
    }
    super.initState();
  }

  void _loadDetails() {
    _updateView(widget.details);
  }

  void _row(ContactRow row) {
    _updateView(ContactDetails(
      firstName: row?.firstName,
      lastName: row?.lastName,
      email: row?.email,
    ));
  }

  void _init() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
  }

  void _updateView(ContactDetails info) {
    _init();

    setState(() {
      _firstName.text = info?.firstName ?? "";
      _lastName.text = info?.lastName ?? "";
      _email.text = info?.email ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactDetailsModel>(
        model: widget.model,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: widget.isNew
                ? const Text("New Contact")
                : const Text("Edit Contact"),
            actions: <Widget>[
              IconButton(
                tooltip: "Import Phone Contact",
                icon: Icon(Icons.import_contacts),
                onPressed: () => selectContact(context).then((contact) {
                      print("Item: " + contact.toString());
                      if (contact != null) {
                        var _info = ContactDetails.fromPhoneContact(contact);
                        print("Contact => " + _info.toJson().toString());
                        _updateView(_info);
                      }
                    }),
              ),
              IconButton(
                tooltip: "Contact Groups",
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
                    name: ContactFields.first_name,
                    autoFocus: true,
                    required: true,
                    controller: _firstName,
                  ),
                  AppInputField(
                    name: ContactFields.last_name,
                    required: true,
                    controller: _lastName,
                  ),
                  AppInputField(
                    name: ContactFields.email,
                    controller: _email,
                  ),
                  Container(height: 10.0),
                  new ScopedModelDescendant<ContactDetailsModel>(
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
                                        widget.isNew
                                            ? "Add Contact"
                                            : "Save Contact",
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
                  new ScopedModelDescendant<ContactDetailsModel>(
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

  ContactDetails getInfoFromInputs() {
    if (_formKey.currentState.validate()) {
      final _info = ContactDetails(
        firstName: _firstName.text ?? "",
        lastName: _lastName.text ?? "",
        email: _email.text ?? "",
      );

      return _info;
    }
    return null;
  }
}

void createContact(BuildContext context, {@required ContactModel model}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditContactScreen(
              model: ContactDetailsModel(auth: model?.auth),
            ),
        fullscreenDialog: true,
      ));
}

void editContact(BuildContext context,
    {@required ContactModel model,
    ContactDetails details,
    @required ContactRow row}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new EditContactScreen(
            model: ContactDetailsModel(auth: model?.auth, id: row?.id),
            isNew: false,
            details: details,
            contactRow: row),
        fullscreenDialog: true,
      ));
}
