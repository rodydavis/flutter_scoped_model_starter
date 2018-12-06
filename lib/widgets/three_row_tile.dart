// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// import '../utils/phoneCall.dart';
// import '../utils/sendEmail.dart';
// import '../utils/sendSMS.dart';
// import '../utils/text_format.dart';

// class ThreeRowTile extends StatelessWidget {
//   final Widget title, subtitle;
//   final Utility box1, box2;
//   final Icon icon;
//   final String cell, home, office, email;
//   final VoidCallback onTap, onLongPress, iconTap, onShare, onDelete, onEdit;
//   final double width;

//   ThreeRowTile({
//     @required this.title,
//     this.icon,
//     this.subtitle,
//     this.home,
//     this.email,
//     this.cell,
//     this.office,
//     this.onTap,
//     this.onLongPress,
//     this.iconTap,
//     this.box1,
//     this.box2,
//     @required this.width,
//     this.onDelete,
//     this.onEdit,
//     this.onShare,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     List<Widget> buildChildren() {
//       List<Widget> builder = [];
//       if (cell.isNotEmpty && !cell.toString().contains("--")) {
//         builder.add(ListTile(
//           leading: const Icon(Icons.phone),
//           title: Text(
//             'Cell',
//             textScaleFactor: textScaleFactor,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             cell.toString().length > 0 ? cell : "No Number Found",
//             textScaleFactor: textScaleFactor,
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.message,
//             ),
//             onPressed: cell == null || cell.isEmpty
//                 ? null
//                 : () {
//                     sendSMS("", [cell.toString()]);
//                   },
//           ),
//           onTap: cell.toString().contains("--")
//               ? null
//               : () => makePhoneCall(context, cell),
//         ));
//       }

//       if (office.isNotEmpty && !office.toString().contains("--")) {
//         builder.add(ListTile(
//           leading: const Icon(Icons.work),
//           title: Text(
//             'Office',
//             textScaleFactor: textScaleFactor,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             office.toString().length > 0 ? office : "No Number Found",
//             textScaleFactor: textScaleFactor,
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.message,
//             ),
//             onPressed: office == null || office.isEmpty
//                 ? null
//                 : () {
//                     sendSMS("", [office.toString()]);
//                   },
//           ),
//           onTap: office.toString().contains("--")
//               ? null
//               : () => makePhoneCall(context, office),
//         ));
//       }
//       if (home.isNotEmpty && !home.toString().contains("--")) {
//         builder.add(ListTile(
//           leading: const Icon(Icons.home),
//           title: Text(
//             'Home',
//             textScaleFactor: textScaleFactor,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             home.toString().length > 0 ? home : "No Number Found",
//             textScaleFactor: textScaleFactor,
//           ),
//           trailing: IconButton(
//             icon: Icon(
//               Icons.message,
//             ),
//             onPressed: home == null || home.isEmpty
//                 ? null
//                 : () {
//                     sendSMS("", [home.toString()]);
//                   },
//           ),
//           onTap: home.toString().contains("--")
//               ? null
//               : () => makePhoneCall(context, home),
//         ));
//       }
//       if (email.isNotEmpty && !email.contains('No Email Address')) {
//         builder.add(ListTile(
//           leading: const Icon(Icons.email),
//           title: Text(
//             'Email',
//             textScaleFactor: textScaleFactor,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           subtitle: Text(
//             email.toString().length > 0 ? email : "No Email Found",
//             textScaleFactor: textScaleFactor,
//           ),
//           onTap: email.toString().isEmpty
//               ? null
//               : () => sendEmail(context, recipients: [email]),
//         ));
//       }
//       if (builder.isEmpty) {
//         builder.add(
//           ListTile(
//             leading: const Icon(Icons.info),
//             title: Text(
//               'No Contact Information Found',
//               textScaleFactor: textScaleFactor,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         );
//       }
//       return builder;
//     }

//     List<Widget> buildUtility() {
//       List<Widget> _utilities = [];

//       if (box1.value.isNotEmpty) {
//         _utilities.add(Container(
//           margin: const EdgeInsets.all(3.0),
//           padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
//           decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey)),
//           child: Tooltip(
//             message: box1?.hint ?? "",
//             child: Text(
//               box1?.value,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               textScaleFactor: textScaleFactor,
//             ),
//           ),
//         ));
//         _utilities.add(Container(width: 10.0));
//       }
//       if (box2.value.isNotEmpty) {
//         _utilities.add(Container(
//           margin: const EdgeInsets.all(3.0),
//           padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 2.0),
//           decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
//           child: Tooltip(
//             message: box2?.hint ?? "",
//             child: Text(
//               box2?.value,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               textScaleFactor: textScaleFactor,
//             ),
//           ),
//         ));
//       }

//       return _utilities;
//     }

//     var rowCard = Container(
//       decoration: BoxDecoration(
//           border: Border(bottom: BorderSide(color: Colors.grey[300]))),
//       child: Container(
//         width: width,
//         padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
//         child: Row(
//           children: <Widget>[
//             Align(
//               child: IconButton(
//                 icon: icon,
//                 onPressed: iconTap,
//               ),
//               alignment: FractionalOffset.centerLeft,
//             ),
//             Expanded(
//               child: InkWell(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     new Align(
//                       child: title,
//                       alignment: FractionalOffset.topLeft,
//                     ),
//                     // new Divider(),
//                     new Align(
//                       child: subtitle,
//                       alignment: FractionalOffset.topLeft,
//                     ),
//                     // new Divider(),
//                     width > 500 || (box1.value.isEmpty && box2.value.isEmpty)
//                         ? Container(
//                             height: 0.0,
//                           )
//                         : Align(
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: buildUtility(),
//                             ),
//                             alignment: FractionalOffset.bottomLeft,
//                           ),
//                   ],
//                 ),
//                 onTap: onTap,
//                 onLongPress: onLongPress,
//               ),
//             ),
//             width < 500 || (box1.value.isEmpty && box2.value.isEmpty)
//                 ? Container(
//                     height: 0.0,
//                   )
//                 : Align(
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: buildUtility(),
//                     ),
//                     alignment: FractionalOffset.centerRight,
//                   ),
//             Align(
//               child: IconButton(
//                 icon: Icon(Icons.arrow_drop_down),
//                 onPressed: () {
//                   showModalBottomSheet<void>(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return SafeArea(
//                             child: SingleChildScrollView(
//                           child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: buildChildren()),
//                         ));
//                       });
//                 },
//               ),
//               alignment: FractionalOffset.centerRight,
//             ),
//           ],
//         ),
//       ),
//       // color: globals.isDarkTheme ? Colors.black45 : Colors.white,
//     );

//     return Container(
//       child: new Slidable(
//         delegate: new SlidableDrawerDelegate(),
//         actionExtentRatio: 0.25,
//         child: rowCard,
//         // -- Left Side --
//         actions: onShare == null
//             ? null
//             : <Widget>[
//                 // -- Share Button --
//                 onShare == null
//                     ? Container()
//                     : new IconSlideAction(
//                         caption: 'Share',
//                         color: Colors.indigo,
//                         icon: Icons.share,
//                         onTap: onShare,
//                       ),
//               ],
//         // -- Right Side --
//         secondaryActions: onDelete == null && onEdit == null
//             ? null
//             : <Widget>[
//                 // -- Edit Button --
//                 onEdit == null
//                     ? Container()
//                     : new IconSlideAction(
//                         caption: 'Edit',
//                         color: Colors.black45,
//                         icon: Icons.edit,
//                         onTap: onEdit,
//                       ),
//                 // -- Delete Button --
//                 onDelete == null
//                     ? Container()
//                     : new IconSlideAction(
//                         caption: 'Delete',
//                         color: Colors.red,
//                         icon: Icons.delete,
//                         onTap: onDelete,
//                       ),
//               ],
//       ),
//     );
//   }
// }

// class Utility {
//   final String value, hint;
//   Utility({this.hint, @required this.value});
// }
