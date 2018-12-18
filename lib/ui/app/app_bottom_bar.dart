import 'package:flutter/material.dart';
import '../../data/models/sort_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AppBottomBar extends StatefulWidget {
  final bool defaultSortOrder;
  final bool showSort;
  final Function(String) onSelectedSortField;
  final Function(bool) onChangeSortOrder;
  final List<IconButton> buttons;

  AppBottomBar({
    this.onSelectedSortField,
    this.onChangeSortOrder,
    this.buttons,
    this.showSort = true,
    this.defaultSortOrder = false,
  });

  @override
  _AppBottomBarState createState() => new _AppBottomBarState();
}

class _AppBottomBarState extends State<AppBottomBar> {
  PersistentBottomSheetController _sortController;

  @override
  Widget build(BuildContext context) {
    final _showSortSheet = () {
      if (_sortController != null) {
        _sortController.close();
        print("Close");
        return;
      }

      _sortController = Scaffold.of(context).showBottomSheet((context) {
        return new ScopedModelDescendant<SortModel>(
          builder: (context, child, model) {
            if (model?.sortFields == null) {
              print("No Fields");
              return Container(
                  color: Theme.of(context).backgroundColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text("No Sort Fields Avaliable"),
                      ),
                    ],
                  ));
            }
            return Container(
              color: Theme.of(context).backgroundColor,
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: model.sortFields.map((_sortField) {
                    var _sortASC = model.sortAscending;
                    return Container(
                        child: ListTile(
                      dense: true,
                      title: Text(_sortField[0].toUpperCase() +
                          _sortField.substring(1)),
                      subtitle: _sortField == model.sortField
                          ? Text(_sortASC ? 'Ascending' : 'Descending')
                          : null,
                      leading: Radio(
                        groupValue: model.sortField,
                        onChanged: (value) => widget.onSelectedSortField(value),
                        value: _sortField,
                      ),
                      onTap: _sortField == model.sortField
                          ? () => widget.onChangeSortOrder(!_sortASC)
                          : null,
                    ));
                  }).toList()),
            );
          },
        );
      });

      _sortController.closed.whenComplete(() {
        print("Done");
        _sortController = null;
      });
    };

    List<Widget> _buttons = [];

    if (widget.showSort) {
      _buttons.add(IconButton(
        tooltip: 'Sort',
        icon: Icon(Icons.sort_by_alpha),
        onPressed: _showSortSheet,
      ));
    }

    if (widget?.buttons != null) _buttons.addAll(widget.buttons);

    return new BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Row(children: _buttons),
    );
  }
}

class AppBottomBarStateless extends StatelessWidget {
  final List<IconButton> buttons;
  AppBottomBarStateless({this.buttons});

  @override
  Widget build(BuildContext context) {
    return new BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: buttons == null ? Container() : Row(children: buttons),
    );
  }
}
