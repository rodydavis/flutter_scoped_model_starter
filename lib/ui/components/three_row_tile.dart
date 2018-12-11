import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../ui/containers/email_tile.dart';
import '../../ui/containers/phone_tile.dart';
import '../../utils/text_format.dart';

class ThreeRowTile extends StatelessWidget {
  final Widget title, subtitle;
  final Utility box1, box2;
  final Icon icon;
  final String cell, home, office, email;
  final VoidCallback onTap, onLongPress, iconTap, onShare, onDelete, onEdit;

  ThreeRowTile({
    @required this.title,
    this.icon,
    this.subtitle,
    this.home,
    this.email,
    this.cell,
    this.office,
    this.onTap,
    this.onLongPress,
    this.iconTap,
    this.box1,
    this.box2,
    this.onDelete,
    this.onEdit,
    this.onShare,
  });

  List<Widget> getActions(BuildContext context) {
    List<Widget> builder = [];
    if (cell.isNotEmpty && !cell.toString().contains("--")) {
      builder.add(buildPhoneTile(context,
          label: "Cell", number: cell, icon: Icons.phone));
    }
    if (office.isNotEmpty && !office.toString().contains("--")) {
      builder.add(buildPhoneTile(context,
          label: "Office", number: office, icon: Icons.work));
    }
    if (home.isNotEmpty && !home.toString().contains("--")) {
      builder.add(buildPhoneTile(context,
          label: "Home", number: home, icon: Icons.home));
    }
    if (email.isNotEmpty && !email.contains('No Email Address')) {
      buildEmailTile(context, label: "Email", email: email);
    }
    return builder;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // List<Widget> buildChildren() {
    //   List<Widget> builder = [];
    //   if (cell.isNotEmpty && !cell.toString().contains("--")) {
    //     builder.add(buildPhoneTile(context,
    //         label: "Cell", number: cell, icon: Icons.phone));
    //   }
    //   if (office.isNotEmpty && !office.toString().contains("--")) {
    //     builder.add(buildPhoneTile(context,
    //         label: "Office", number: office, icon: Icons.work));
    //   }
    //   if (home.isNotEmpty && !home.toString().contains("--")) {
    //     builder.add(buildPhoneTile(context,
    //         label: "Home", number: home, icon: Icons.home));
    //   }
    //   if (email.isNotEmpty && !email.contains('No Email Address')) {
    //     buildEmailTile(context, label: "Email", email: email);
    //   }
    //   if (builder.isEmpty) {
    //     builder.add(
    //       ListTile(
    //         leading: const Icon(Icons.info),
    //         title: Text(
    //           'No Contact Information Found',
    //           textScaleFactor: textScaleFactor,
    //           style: TextStyle(
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //       ),
    //     );
    //   }
    //   return builder;
    // }

    List<Widget> buildUtility() {
      List<Widget> _utilities = [];

      if (box1.value.isNotEmpty) {
        _utilities.add(Container(
          margin: const EdgeInsets.all(3.0),
          padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
          child: Tooltip(
            message: box1?.hint ?? "",
            child: Text(
              box1?.value,
              maxLines: 1,
              textAlign: TextAlign.center,
              textScaleFactor: textScaleFactor,
            ),
          ),
        ));
        _utilities.add(Container(width: 10.0));
      }
      if (box2.value.isNotEmpty) {
        _utilities.add(Container(
          margin: const EdgeInsets.all(3.0),
          padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Tooltip(
            message: box2?.hint ?? "",
            child: Text(
              box2?.value,
              maxLines: 1,
              textAlign: TextAlign.center,
              textScaleFactor: textScaleFactor,
            ),
          ),
        ));
      }

      return _utilities;
    }

    var rowCard = Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[300]))),
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
        child: Row(
          children: <Widget>[
            icon != null
                ? Align(
                    child: IconButton(
                      icon: icon,
                      onPressed: iconTap,
                    ),
                    alignment: FractionalOffset.centerLeft,
                  )
                : Container(),
            Expanded(
              child: InkWell(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new Align(
                      child: title,
                      alignment: FractionalOffset.topLeft,
                    ),
                    // new Divider(),
                    new Align(
                      child: subtitle,
                      alignment: FractionalOffset.topLeft,
                    ),
                    // new Divider(),
                    width > 500 ||
                            ((box1?.value?.isEmpty ?? true) &&
                                (box2?.value?.isEmpty ?? true))
                        ? Container(
                            height: 0.0,
                          )
                        : Align(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: buildUtility(),
                            ),
                            alignment: FractionalOffset.bottomLeft,
                          ),
                  ],
                ),
                onTap: onTap,
                onLongPress: onLongPress,
              ),
            ),
            width < 500 ||
                    ((box1?.value?.isEmpty ?? true) &&
                        (box2?.value?.isEmpty ?? true))
                ? Container(
                    height: 0.0,
                  )
                : Align(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: buildUtility(),
                    ),
                    alignment: FractionalOffset.centerRight,
                  ),
            Align(
              child: getActions(context).isEmpty
                  ? Container()
                  : IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SafeArea(
                                  child: SingleChildScrollView(
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: getActions(context)),
                              ));
                            });
                      },
                    ),
              alignment: FractionalOffset.centerRight,
            ),
          ],
        ),
      ),
      // color: globals.isDarkTheme ? Colors.black45 : Colors.white,
    );

    return Container(
      child: new Slidable(
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.25,
        child: rowCard,
        // -- Left Side --
        actions: onShare == null
            ? null
            : <Widget>[
                // -- Share Button --
                onShare == null
                    ? Container()
                    : new IconSlideAction(
                        caption: 'Share',
                        color: Colors.indigo,
                        icon: Icons.share,
                        onTap: onShare,
                      ),
              ],
        // -- Right Side --
        secondaryActions: onDelete == null && onEdit == null
            ? null
            : <Widget>[
                // -- Edit Button --
                onEdit == null
                    ? Container()
                    : new IconSlideAction(
                        caption: 'Edit',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: onEdit,
                      ),
                // -- Delete Button --
                onDelete == null
                    ? Container()
                    : new IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: onDelete,
                      ),
              ],
      ),
    );
  }
}

class Utility {
  final String value, hint;
  Utility({this.hint, @required this.value});
}
