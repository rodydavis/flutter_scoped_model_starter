import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/general/phone.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';
import '../../data/models/leads/list.dart';
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
import '../../data/models/leads/groups.dart';
import 'groups/manage.dart';
import 'edit.dart';

class LeadDetailsScreen extends StatelessWidget {
  final LeadModel leadModel;
  final LeadGroupModel groupModel;
  final LeadRow leadRow;

  LeadDetailsScreen({this.leadModel, this.leadRow, @required this.groupModel});

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
                  number: leadRow?.cellPhone,
                  icon: Icons.phone),
              PhoneTile(
                  label: "Home Phone",
                  number: leadRow?.homePhone,
                  icon: Icons.home),
              PhoneTile(
                  label: "Office Phone",
                  number: leadRow?.officePhone,
                  icon: Icons.work),
              new ScopedModelDescendant<LeadDetailsModel>(
//                  rebuildOnChange: true,
                  builder: (context, child, model) {
                if (model.details != null) {
                  final _details = model.details;

                  var _groupTiles = <Widget>[];

                  if (_details?.leadGroups != null &&
                      _details.leadGroups.isNotEmpty) {
                    for (var _item in _details.leadGroups) {
                      _groupTiles.add(ListTile(
                        title: Text(_item?.name ?? "No Name Found"),
                        trailing: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () async {
                              var _groups = _details.leadGroups;
                              _groups.remove(_item);
                              await model.edit(_details);
                            }),
                      ));
                    }
                  }

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
                      _groupTiles.isNotEmpty
                          ? ExpansionTile(
                              leading: Icon(Icons.group),
                              title: Text("Lead Groups"),
                              children: _groupTiles,
                            )
                          : Container(),
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
              new ScopedModelDescendant<LeadDetailsModel>(
                  builder: (context, child, model) => IconButton(
                        tooltip: "Lead Groups",
                        icon: Icon(Icons.group),
                        onPressed: () async {
                          var _groups = await manageGroups(context,
                              initial: model.details?.leadGroups ?? [],
                              model: groupModel);
                          if (_groups != null) {
                            var _details = model?.details;
                            _details.leadGroups = _groups;
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
          floatingActionButton: new ScopedModelDescendant<LeadDetailsModel>(
//                  rebuildOnChange: true,
              builder: (context, child, model) => FloatingActionButton(
                    heroTag: "Lead Edit",
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () => editLead(
                          context,
                          model: leadModel,
                          details: model.details,
                          leadRow: leadRow,
                          groupModel: groupModel,
                        ),
                    child: Icon(Icons.edit, color: Colors.white),
                    tooltip: 'Edit Item',
                  )),
        ));
  }
}

void viewLead(BuildContext context,
    {@required LeadModel model,
    LeadRow leadRow,
    @required LeadGroupModel groupModel}) {
  Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new LeadDetailsScreen(
              leadModel: model,
              leadRow: leadRow,
              groupModel: groupModel,
            ),
        fullscreenDialog: false,
      ));
}
