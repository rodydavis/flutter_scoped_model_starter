import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/details.dart';
import '../../data/models/contacts/list.dart';
import '../app/app_bottom_bar.dart';
import '../general/address_tile.dart';
import '../general/phone_tile.dart';
import 'edit.dart';
import '../app/buttons/app_delete_button.dart';
import '../app/buttons/app_share_button.dart';
import 'package:contacts_service/contacts_service.dart';
import '../app/buttons/app_share_button.dart';
import '../../utils/vcf_card.dart';
import '../../data/classes/contacts/contact_details.dart';

class LeadDetailsScreen extends StatelessWidget {
  final ContactRow contactRow;
  final ContactModel contactModel;

  LeadDetailsScreen({
    @required this.contactRow,
    @required this.contactModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactDetailsModel>(
        model: ContactDetailsModel(id: contactRow.id, auth: contactModel?.auth),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Details"),
            actions: <Widget>[
              new ScopedModelDescendant<ContactDetailsModel>(
                  builder: (context, child, model) => IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          final Contact _info = Contact(
                            givenName: model.details?.firstName,
                            familyName: model.details?.lastName,
                            company: "Unify Contact",
                            phones: [
                              Item(
                                  label: "home",
                                  value: model.details?.homePhone?.toString()),
                              Item(
                                  label: "cell",
                                  value: model.details?.cellPhone?.toString()),
                              Item(
                                  label: "work",
                                  value:
                                      model.details?.officePhone?.toString()),
                            ],
                            emails: [
                              Item(label: "home", value: model.details?.email),
                            ],
                            postalAddresses: [
                              PostalAddress(
                                label: "home",
                                street: model.details?.address?.street,
                                city: model.details?.address?.city,
                                region: model.details?.address?.state,
                                postcode: model.details?.address?.zip,
                              ),
                            ],
                          );
                          generateVCARD(context, contact: _info).then((file) {
                            if (file != null) {
                              shareFile(context, file: file);
                            }
                          });
                        },
                      )),
            ],
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                    ((contactRow?.firstName ?? "") + " " + contactRow?.lastName)
                        .trim()),
              ),
              PhoneTile(
                  label: "Cell Phone",
                  number: contactRow?.cellPhone,
                  icon: Icons.phone),
              PhoneTile(
                  label: "Home Phone",
                  number: contactRow?.homePhone,
                  icon: Icons.home),
              PhoneTile(
                  label: "Office Phone",
                  number: contactRow?.officePhone,
                  icon: Icons.work),
              new ScopedModelDescendant<ContactDetailsModel>(
//                  rebuildOnChange: true,
                  builder: (context, child, model) {
                if (model.details != null) {
                  final _details = model.details;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AddressTile(
                        address: _details?.address,
                        label: "Current Address",
                        icon: Icons.map,
                      ),
                    ],
                  );
                }
                model.loadData();
                return Center(child: CircularProgressIndicator());
              }),
            ],
          ),
          bottomNavigationBar: AppBottomBar(
            // showSort: false,
            buttons: [
              new ScopedModelDescendant<ContactDetailsModel>(
                  builder: (context, child, model) =>
                      AppDeleteButton(onDelete: () async {
                        await model.delete();
                        Navigator.pop(context);
                      })),
              IconButton(
                tooltip: "Lead Groups",
                icon: Icon(Icons.people),
                onPressed: () => null,
              ),
              IconButton(
                tooltip: "Add Follow Up",
                icon: Icon(Icons.event_available),
                onPressed: null,
              ),
              IconButton(
                tooltip: "Add Note",
                icon: Icon(Icons.note_add),
                onPressed: null,
              ),
              IconButton(
                tooltip: "Add Log Response",
                icon: Icon(Icons.timer),
                onPressed: null,
              ),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: new ScopedModelDescendant<ContactDetailsModel>(
//                  rebuildOnChange: true,
              builder: (context, child, model) => FloatingActionButton(
                    heroTag: "Lead Edit",
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () => editContact(context,
                        model: contactModel,
                        details: model.details,
                        row: contactRow),
                    child: Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Item',
                  )),
        ));
  }
}

void viewContact(BuildContext context,
    {@required ContactModel model, @required ContactRow row}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LeadDetailsScreen(
              contactRow: row,
              contactModel: model,
            ),
        fullscreenDialog: false,
      ));
}
