import 'package:flutter/material.dart';
import 'package:flutter_scoped_model_starter/ui/app/buttons/app_refresh_button.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../data/models/leads/groups.dart';
import '../../../data/models/leads/list.dart';
import '../../app/app_bottom_bar.dart';
import '../../general/list_widget.dart';
import '../../general/simple_fab.dart';
import 'edit.dart';
import 'item.dart';
import 'view.dart';

class LeadGroupsScreen extends StatelessWidget {
  final LeadGroupModel groupModel;
  final LeadModel leadModel;

  LeadGroupsScreen({
    this.groupModel,
    @required this.leadModel,
  });

  @override
  Widget build(BuildContext context) {
    return ScopedModel<LeadGroupModel>(
        model: groupModel,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Lead Groups"),
          ),
          body: new ScopedModelDescendant<LeadGroupModel>(
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
                              onTap: () => viewLeadGroup(context,
                                          model: leadModel, group: _group)
                                      .then((edited) {
                                    if (edited != null) {
                                      model.refreshGroups();
                                    }
                                  }),
                              onLongPressed: () => editGroup(context,
                                          model: leadModel, group: _group)
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
              new ScopedModelDescendant<LeadGroupModel>(
                  builder: (context, child, model) => AppRefreshButton(
                        isRefreshing: model.fetching,
                        onRefresh: model.refreshGroups,
                      )),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: new ScopedModelDescendant<LeadGroupModel>(
              builder: (context, child, model) => SimpleFAB(
                    child: Icon(Icons.group_add),
                    onPressed: () =>
                        createGroup(context, model: leadModel).then((created) {
                          if (created != null) model.refreshGroups();
                        }),
                  )),
        ));
  }
}
