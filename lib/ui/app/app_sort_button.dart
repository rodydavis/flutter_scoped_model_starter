import 'package:flutter/material.dart';
import '../../data/classes/app/sort.dart';

class AppSortButton extends StatefulWidget {
  final Sort sort;
  final ValueChanged<Sort> sortChanged;

  AppSortButton({
    this.sort,
    this.sortChanged,
  });

  @override
  AppSortButtonState createState() {
    return new AppSortButtonState();
  }
}

class AppSortButtonState extends State<AppSortButton> {
  PersistentBottomSheetController _sortController;
  Sort sort;
  @override
  void initState() {
    setState(() {
      sort = widget.sort;
    });
    print("Sort: " + sort?.toJson().toString());
    super.initState();
  }

  void _sortFieldChanged(String value) {
    setState(() {
      sort.field = value;
    });
    widget.sortChanged(sort);
  }

  void _sortOrderChanged(bool value) {
    setState(() {
      sort.ascending = value;
    });
    widget.sortChanged(sort);
  }

  @override
  Widget build(BuildContext context) {
    final _showSortSheet = () {
      if (_sortController != null) {
        _sortController.close();
        print("Close");
        return;
      }

      _sortController = Scaffold.of(context).showBottomSheet((context) {
        if (sort?.fields == null) {
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
              children: sort.fields.map((_sortField) {
                var _sortASC = sort.ascending;
                return Container(
                    child: ListTile(
                  dense: true,
                  title: Text(
                      _sortField[0].toUpperCase() + _sortField.substring(1)),
                  subtitle: _sortField == sort.field
                      ? Text(_sortASC ? 'Ascending' : 'Descending')
                      : null,
                  leading: Radio(
                    groupValue: sort.field,
                    onChanged: (value) => _sortFieldChanged(value),
                    value: _sortField,
                  ),
                  onTap: _sortField == sort.field
                      ? () => _sortOrderChanged(!_sortASC)
                      : null,
                ));
              }).toList()),
        );
      });

      _sortController.closed.whenComplete(() {
        print("Done");
        _sortController = null;
      });
    };

    return IconButton(
      icon: Icon(Icons.sort_by_alpha),
      onPressed: () => _showSortSheet(),
    );
  }
}
