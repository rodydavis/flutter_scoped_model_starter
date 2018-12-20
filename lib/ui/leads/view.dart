import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/general/phone.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';
import '../../data/models/leads/list.dart';
import '../../utils/vcf_card.dart';
import '../app/app_bottom_bar.dart';
import '../app/buttons/app_delete_button.dart';
import '../app/buttons/app_share_button.dart';
import '../general/address_tile.dart';
import '../../utils/null_or_empty.dart';
import '../general/phone_tile.dart';
import 'edit.dart';

class LeadDetailsScreen extends StatelessWidget {
  final LeadModel leadModel;
  final LeadRow leadRow;

  LeadDetailsScreen({this.leadModel, this.leadRow});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadDetailsModel>(
        model: LeadDetailsModel(id: leadRow.id, auth: leadModel?.auth),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Details"),
            actions: <Widget>[
              new ScopedModelDescendant<LeadDetailsModel>(
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

                          if (!isNullOrEmpty(
                              model.details?.currentAddress?.raw())) {
                            _addresses.add(PostalAddress(
                              label: "home",
                              street: model.details?.currentAddress?.street,
                              city: model.details?.currentAddress?.city,
                              region: model.details?.currentAddress?.state,
                              postcode: model.details?.currentAddress?.zip,
                              country: "USA",
                            ));
                          }

                          if (!isNullOrEmpty(
                              model.details?.propertyAddress?.raw())) {
                            _addresses.add(PostalAddress(
                              label: "work",
                              street: model.details?.propertyAddress?.street,
                              city: model.details?.propertyAddress?.city,
                              region: model.details?.propertyAddress?.state,
                              postcode: model.details?.propertyAddress?.zip,
                              country: "USA",
                            ));
                          }

                          final Contact _info = Contact(
                            givenName: model.details?.firstName,
                            familyName: model.details?.lastName,
                            company: "Unify Lead",
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
          body: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.info),
                title: Text(
                    ((leadRow?.firstName ?? "") + " " + leadRow?.lastName)
                        .trim()),
              ),
              PhoneTile(
                  label: "Cell Phone",
                  number: Phone.fromString(leadRow?.cellPhone),
                  icon: Icons.phone),
              PhoneTile(
                  label: "Home Phone",
                  number: Phone.fromString(leadRow?.homePhone),
                  icon: Icons.home),
              PhoneTile(
                  label: "Office Phone",
                  number: Phone.fromString(leadRow?.officePhone),
                  icon: Icons.work),
              new ScopedModelDescendant<LeadDetailsModel>(
//                  rebuildOnChange: true,
                  builder: (context, child, model) {
                if (model.details != null) {
                  final _details = model.details;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AddressTile(
                        address: _details?.currentAddress,
                        label: "Current Address",
                        icon: Icons.map,
                      ),
                      AddressTile(
                        address: _details?.propertyAddress,
                        label: "Property Address",
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
              new ScopedModelDescendant<LeadDetailsModel>(
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
          floatingActionButton: new ScopedModelDescendant<LeadDetailsModel>(
//                  rebuildOnChange: true,
              builder: (context, child, model) => FloatingActionButton(
                    heroTag: "Lead Edit",
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () => editLead(context,
                        model: leadModel,
                        details: model.details,
                        leadRow: leadRow),
                    child: Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Item',
                  )),
        ));
  }
}

void viewLead(BuildContext context,
    {@required LeadModel model, LeadRow leadRow}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LeadDetailsScreen(
              leadModel: model,
              leadRow: leadRow,
            ),
        fullscreenDialog: false,
      ));
}
