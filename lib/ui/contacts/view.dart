import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/details.dart';
import '../../data/models/contacts/groups.dart';
import '../../data/models/contacts/list.dart';
import '../../utils/null_or_empty.dart';
import '../../utils/vcf_card.dart';
import '../actions/follow_up.dart';
import '../actions/log_response.dart';
import '../actions/note.dart';
import '../app/app_bottom_bar.dart';
import '../app/buttons/app_delete_button.dart';
import '../app/buttons/app_share_button.dart';
import '../general/address_tile.dart';
import '../general/phone_tile.dart';
import 'edit.dart';
import 'groups/manage.dart';

class LeadDetailsScreen extends StatelessWidget {
  final ContactRow contactRow;
  final ContactModel contactModel;
  final ContactGroupModel groupModel;

  LeadDetailsScreen({
    @required this.contactRow,
    @required this.contactModel,
    @required this.groupModel,
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
                          var _phones = <Item>[];

                          if (!isNullOrEmpty(
                              model?.details?.cellPhone?.raw())) {
                            _phones.add(Item(
                                label: "cell",
                                value: model.details?.cellPhone?.toString()));
                          }

                          if (!isNullOrEmpty(
                              model?.details?.homePhone?.raw())) {
                            _phones.add(Item(
                                label: "home",
                                value: model.details?.homePhone?.toString()));
                          }

                          if (!isNullOrEmpty(
                              model?.details?.officePhone?.raw())) {
                            _phones.add(Item(
                                label: "work",
                                value: model.details?.officePhone?.toString()));
                          }

                          var _emails = <Item>[];

                          if (!isNullOrEmpty(model.details?.email)) {
                            _emails.add(Item(
                                label: "home", value: model.details?.email));
                          }

                          var _addresses = <PostalAddress>[];

                          if (!isNullOrEmpty(model.details?.address?.raw())) {
                            _addresses.add(PostalAddress(
                              label: "home",
                              street: model.details?.address?.street,
                              city: model.details?.address?.city,
                              region: model.details?.address?.state,
                              postcode: model.details?.address?.zip,
                              country: "USA",
                            ));
                          }

                          final Contact _info = Contact(
                            givenName: model.details?.firstName,
                            familyName: model.details?.lastName,
                            company: "Unify Contact",
                            phones: _phones,
                            emails: _emails,
                            postalAddresses: _addresses,
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
          body: new ScopedModelDescendant<ContactDetailsModel>(
//                  rebuildOnChange: true,
              builder: (context, child, model) {
            if (model.details != null) {
              final _details = model.details;

              var _groupTiles = <Widget>[];

              if (_details?.contactGroups != null &&
                  _details.contactGroups.isNotEmpty) {
                for (var _item in _details.contactGroups) {
                  _groupTiles.add(ListTile(
                    title: Text(_item?.name ?? "No Name Found"),
                    trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () async {
                          var _groups = _details.contactGroups;
                          _groups.remove(_item);
                          await model.edit(_details);
                        }),
                  ));
                }
              }

              return ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.info),
                    title: Text(
                        ((_details?.firstName ?? "") + " " + _details?.lastName)
                            .trim()),
                  ),
                  PhoneTile(
                      label: "Cell Phone",
                      number: _details?.cellPhone,
                      icon: Icons.phone),
                  PhoneTile(
                      label: "Home Phone",
                      number: _details?.homePhone,
                      icon: Icons.home),
                  PhoneTile(
                      label: "Office Phone",
                      number: _details?.officePhone,
                      icon: Icons.work),
                  AddressTile(
                    address: _details?.address,
                    label: "Current Address",
                    icon: Icons.map,
                  ),
                  _groupTiles.isNotEmpty
                      ? ExpansionTile(
                          leading: Icon(Icons.group),
                          title: Text("Contact Groups"),
                          children: _groupTiles,
                        )
                      : Container(),
                ],
              );
            }

            model.loadData();

            return ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text(((contactRow?.firstName ?? "") +
                          " " +
                          contactRow?.lastName)
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
                Center(child: CircularProgressIndicator()),
              ],
            );
          }),
          bottomNavigationBar: AppBottomBar(
            // showSort: false,
            buttons: [
              new ScopedModelDescendant<ContactDetailsModel>(
                  builder: (context, child, model) =>
                      AppDeleteButton(onDelete: () async {
                        await model.delete();
                        Navigator.pop(context);
                      })),
              new ScopedModelDescendant<ContactDetailsModel>(
                  builder: (context, child, model) => IconButton(
                        tooltip: "Contact Groups",
                        icon: Icon(Icons.group),
                        onPressed: () async {
                          var _groups = await manageGroups(context,
                              initial: model.details?.contactGroups ?? [],
                              model: groupModel);
                          if (_groups != null) {
                            var _details = model?.details;
                            _details.contactGroups = _groups;
                            await model.edit(_details);
                          }
                        },
                      )),
              IconButton(
                tooltip: "Add Follow Up",
                icon: Icon(Icons.event_available),
                onPressed: () => createFollowUp(context),
              ),
              IconButton(
                tooltip: "Add Note",
                icon: Icon(Icons.note_add),
                onPressed: () => createNote(context),
              ),
              IconButton(
                tooltip: "Add Log Response",
                icon: Icon(Icons.timer),
                onPressed: () => createLogResponse(context),
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
                        groupModel: groupModel,
                        row: contactRow),
                    child: Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Item',
                  )),
        ));
  }
}

void viewContact(BuildContext context,
    {@required ContactModel model,
    @required ContactRow row,
    @required ContactGroupModel groupModel}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LeadDetailsScreen(
              contactRow: row,
              contactModel: model,
              groupModel: groupModel,
            ),
        fullscreenDialog: false,
      ));
}
