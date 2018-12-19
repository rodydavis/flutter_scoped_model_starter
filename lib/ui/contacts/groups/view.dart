import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_sort_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/contacts/groups.dart';
import '../../../data/models/contacts/list.dart';
import '../../app/app_bottom_bar.dart';
import '../../app/buttons/app_delete_button.dart';
import '../../general/list_widget.dart';
import '../item.dart';
import 'edit.dart';

class ContactsFromGroupScreen extends StatelessWidget {
  final ContactGroup group;
  final ContactModel contactModel;

  ContactsFromGroupScreen({
    @required this.contactModel,
    @required this.group,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactGroupModel>(
      model: ContactGroupModel(auth: contactModel?.auth, id: group?.id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(group.name ?? "No Group Name"),
          actions: <Widget>[
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) => IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () =>
                          editGroup(context, model: contactModel, group: group),
                    )),
          ],
        ),
        body: new ScopedModelDescendant<ContactGroupModel>(
            builder: (context, child, model) => RefreshIndicator(
                  onRefresh: model.refresh,
                  child: ListWidget(
                    onEmpty: Center(child: Text("No Contacts Found")),
                    items: model.contacts,
                    child: ListView.builder(
                      itemCount: model?.contacts?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final _info = model.contacts[index];
                        if (index == model.contacts.length - 1)
                          model.fetchNext();
                        return ContactItem(model: contactModel, contact: _info);
                      },
                    ),
                  ),
                )),
        bottomNavigationBar: AppBottomBar(
          buttons: [
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) => AppSortButton(
                      sort: model.sort,
                      sortChanged: model.sortChanged,
                    )),
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) => AppRefreshButton(
                      isRefreshing: model.fetching,
                      onRefresh: model.refresh,
                    )),
            new ScopedModelDescendant<ContactGroupModel>(
                builder: (context, child, model) =>
                    model.contacts == null || model.contacts.isEmpty
                        ? AppDeleteButton(onDelete: () async {
                            await model.deleteContactGroup(id: group.id);
                            Navigator.pop(context);
                          })
                        : Container(height: 48.0))
          ],
        ),
      ),
    );
  }
}

void viewGroup(BuildContext context,
    {@required ContactModel model, @required ContactGroup group}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          ContactsFromGroupScreen(contactModel: model, group: group),
    ),
  );
}
