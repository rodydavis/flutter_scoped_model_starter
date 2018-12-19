import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/contacts/list.dart';
import '../../data/classes/contacts/contact_details.dart';
import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/details.dart';

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
  ContactDetails contact;

  @override
  void initState() {
    if (!widget.isNew) {
      if (widget.contactRow != null) _loadRow();
      if (widget.details != null) _loadDetails();
    }
    _updateView();
    super.initState();
  }

  void _loadDetails() {
    setState(() {
      contact = widget.details;
    });
  }

  void _loadRow() {
    setState(() {
      contact = ContactDetails(
        firstName: widget.contactRow?.firstName,
        lastName: widget.contactRow?.lastName,
        email: widget.contactRow?.email,
      );
    });
  }

  void _updateView() {
    _firstName = TextEditingController(text: contact?.firstName ?? "");
    _lastName = TextEditingController(text: contact?.lastName ?? "");
    _email = TextEditingController(text: contact?.email ?? "");
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
//                onPressed: () => Navigator.pushNamed(context, "/import_single")
//                        .then((value) {
//                      if (value != null) _updateView(phoneContact: value);
//                    }),
                onPressed: null,
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
              onChanged: _onFormChange,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: TextFormField(
                      controller: _firstName,
                      autofocus: true,
                      decoration:
                          InputDecoration(labelText: ContactFields.first_name),
                      keyboardType: TextInputType.text,
                      validator: (val) => val.isEmpty
                          ? 'Please enter a ${ContactFields.first_name}'
                          : null,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: _lastName,
                      decoration:
                          InputDecoration(labelText: ContactFields.last_name),
                      keyboardType: TextInputType.text,
                      validator: (val) => val.isEmpty
                          ? 'Please enter a ${ContactFields.last_name}'
                          : null,
                    ),
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: _email,
                      decoration:
                          InputDecoration(labelText: ContactFields.email),
                      keyboardType: TextInputType.emailAddress,
                      validator: (val) =>
                          val != null && val.isNotEmpty && !val.contains("@")
                              ? 'Please enter a valid ${ContactFields.email}'
                              : null,
                    ),
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
                                        if (_formKey.currentState.validate()) {
                                          print("Saving Info...");
                                          print(contact?.toJson());

                                          if (widget.isNew) {
                                            await model.add(contact);
                                          } else {
                                            await model.edit(contact);
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

  void _onFormChange() {
    final _newLead = ContactDetails(
      firstName: _firstName.text ?? "",
      lastName: _lastName.text ?? "",
      email: _email.text ?? "",
    );
    setState(() {
      contact = _newLead;
    });
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
