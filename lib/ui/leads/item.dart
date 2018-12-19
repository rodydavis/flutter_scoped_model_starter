import 'package:flutter/material.dart';

import '../../data/classes/general/phone.dart';
import '../../data/classes/leads/lead_row.dart';
import '../../data/models/leads/list.dart';
import '../general/three_row_tile.dart';
import 'edit.dart';
import 'view.dart';
import '../../utils/date_formatter.dart';
import '../app/buttons/app_share_button.dart';
import '../../utils/popUp.dart';

class LeadItem extends StatelessWidget {
  final LeadRow lead;
  final LeadModel model;

  LeadItem({@required this.lead, @required this.model});

  @override
  Widget build(BuildContext context) {
    return ThreeRowTile(
      icon: Icon(Icons.person),
      title: Text(lead?.displayName),
      subtitle: Text(lead?.lastActivity),
      onTap: () => viewLead(context, model: model, leadRow: lead),
      onLongPress: () => editLead(context, model: model, leadRow: lead),
      cell: Phone.fromString(lead?.cellPhone),
      home: Phone.fromString(lead?.homePhone),
      office: Phone.fromString(lead?.officePhone),
      email: lead?.email,
      box1: Utility(
        value: formatDateCustom(lead?.dateCreated),
        hint: "Date Created",
      ),
      // box2: Utility(
      //   value: formatDate(lead?.dateModified),
      //   hint: "Date Modified",
      // ),
      onDelete: () => showConfirmationPopup(context,
          detail: "Are you sure you want to delete?"),
      onEdit: () => editLead(context, model: model, leadRow: lead),
      onShare: () => shareText(context, text: lead.toString()),
    );
  }
}
