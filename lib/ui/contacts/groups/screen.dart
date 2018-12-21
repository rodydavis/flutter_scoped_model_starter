import 'package:flutter/material.dart';

import '../../../data/classes/unify/contact_group.dart';
import '../../../data/models/auth_model.dart';
import '../../../data/models/contacts/groups.dart';
import '../../../data/models/contacts/list.dart';
import 'edit.dart';
import 'item.dart';
import 'view.dart';
import '../../general/list_widget.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../app/app_bottom_bar.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import '../../general/simple_fab.dart';

class ContactGroupsScreen extends StatelessWidget {
  final ContactGroupModel groupModel;
  final ContactModel contactModel;

  ContactGroupsScreen({
    this.groupModel,
    @required this.contactModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ContactGroupModel>(
        model: groupModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Contact Groups"),
          ),
          body: new ScopedModelDescendant<ContactGroupModel>(
              builder: (context, child, model) => ListWidget(
                  items: model?.groups,
                  onEmpty: Center(
                    child: Text("No Groups Found"),
                  ),
                  child: RefreshIndicator(
                      onRefresh: model.refreshGroups,
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                        itemCount: model?.groups?.length,
                        itemBuilder: (BuildContext context, int index) {
                          final _group = model?.groups[index];
                          return SafeArea(
                            child: WrapItem(
                              _group,
                              true,
                              index: index,
                              onTap: () => viewGroup(context,
                                          model: contactModel, group: _group)
                                      .then((edited) {
                                    if (edited != null) {
                                      model.refreshGroups();
                                    }
                                  }),
                              onLongPressed: () => editGroup(context,
                                          model: contactModel, group: _group)
                                      .then((edited) {
                                    if (edited != null) {
                                      model.refreshGroups();
                                    }
                                  }),
                            ),
                          );
                        },
                      )))),
          bottomNavigationBar: AppBottomBar(
            buttons: [
              new ScopedModelDescendant<ContactGroupModel>(
                  builder: (context, child, model) => AppRefreshButton(
                        isRefreshing: model.fetching,
                        onRefresh: model.refreshGroups,
                      )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: SimpleFAB(
            child: Icon(Icons.group_add),
            onPressed: () => createGroup(context, model: contactModel),
          ),
        ));
  }
}
