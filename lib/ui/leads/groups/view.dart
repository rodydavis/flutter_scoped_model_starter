import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_sort_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/leads/groups.dart';
import '../../../data/models/leads/list.dart';
import '../../app/app_bottom_bar.dart';
import '../../app/buttons/app_delete_button.dart';
import '../../general/list_widget.dart';
import '../item.dart';
import 'edit.dart';

class ContactsFromGroupScreen extends StatelessWidget {
  final ContactGroup group;
  final LeadModel leadModel;

  ContactsFromGroupScreen({
    @required this.leadModel,
    @required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadGroupModel>(
      model: LeadGroupModel(auth: leadModel?.auth, id: group?.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.name ?? "No Group Name"),
          actions: <Widget>[
            new ScopedModelDescendant<LeadGroupModel>(
                builder: (context, child, model) => IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          editGroup(context, model: leadModel, group: group)
                              .then((edited) {
                            if (edited != null) {
                              Navigator.pop(context, edited);
                            }
                          }),
                    )),
          ],
        ),
        body: new ScopedModelDescendant<LeadGroupModel>(
            builder: (context, child, model) => RefreshIndicator(
                  onRefresh: model.refresh,
                  child: ListWidget(
                    onEmpty: Center(child: Text("No Leads Found")),
                    items: model.leads,
                    child: ListView.builder(
                      itemCount: model?.leads?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final _info = model.leads[index];
                        if (index == model.leads.length - 1 &&
                            !model.isSearching) model.fetchNext();
                        return LeadItem(
                          model: leadModel,
                          lead: _info,
                          groupModel: model,
                        );
                      },
                    ),
                  ),
                )),
        bottomNavigationBar: AppBottomBar(
          buttons: [
            new ScopedModelDescendant<LeadGroupModel>(
                builder: (context, child, model) => AppSortButton(
                      sort: model.sort,
                      sortChanged: model.sortChanged,
                    )),
            new ScopedModelDescendant<LeadGroupModel>(
                builder: (context, child, model) => AppRefreshButton(
                      isRefreshing: model.fetching,
                      onRefresh: model.refresh,
                      onCancel: model.cancel,
                    )),
            new ScopedModelDescendant<LeadGroupModel>(
                builder: (context, child, model) =>
                    model.leads == null || model.leads.isEmpty
                        ? AppDeleteButton(onDelete: () async {
                            await model.deleteContactGroup(id: group.id);
                            Navigator.pop(context, false);
                          })
                        : Container(height: 48.0))
          ],
        ),
      ),
    );
  }
}

Future<bool> viewLeadGroup(BuildContext context,
    {@required LeadModel model, @required ContactGroup group}) async {
  var _edited = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ContactsFromGroupScreen(leadModel: model, group: group),
    ),
  );
  return _edited; //True = Edited, False = Deleted
}
