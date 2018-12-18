import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/details.dart';
import '../../data/models/leads/list.dart';
import '../app/app_bottom_bar.dart';
import 'edit.dart';
import '../general/address_tile.dart';
import '../general/phone_tile.dart';
import '../../data/classes/general/phone.dart';

class LeadDetailsScreen extends StatelessWidget {
  final LeadModel leadModel;
  final LeadRow leadRow;

  LeadDetailsScreen({this.leadModel, this.leadRow});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadDetailsModel>(
        model: LeadDetailsModel(id: leadRow.id, authModel: leadModel?.auth),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Details"),
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
                if (model.isLoaded) {
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
//                  rebuildOnChange: true,
                  builder: (context, child, model) => IconButton(
                        tooltip: "Delete Lead",
                        icon: Icon(Icons.delete),
                        // onPressed: () {
                        //   //Todo: Ask for Confirmation
                        //   widget.model.deleteItem(context, id: item?.id);
                        //   Navigator.pop(context);
                        // },
                        onPressed: model.delete,
                      )),
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
                        model: leadModel, details: model.details),
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
