import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/classes/contacts/contact_row.dart';
import '../../data/models/contacts/list.dart';
import '../../utils/date_formatter.dart';
import '../../utils/popUp.dart';
import '../app/buttons/app_share_button.dart';
import 'package:share_extend/share_extend.dart';
import '../general/three_row_tile.dart';
import '../../utils/null_or_empty.dart';
import 'edit.dart';
import 'view.dart';

class ContactItem extends StatelessWidget {
  final ContactRow contact;
  final ContactModel model;

  ContactItem({@required this.contact, @required this.model});

  @override
  Widget build(BuildContext context) {
    return ThreeRowTile(
      icon: Icon(Icons.person),
      title: Text(contact?.displayName),
//      subtitle: Text(contact?.lastActivity),
      onTap: () => viewLead(context, model: model, row: contact),
      onLongPress: () => editContact(context, model: model, row: contact),
      cell: contact?.cellPhone,
      home: contact?.homePhone,
      office: contact?.officePhone,
      email: contact?.email,
      box1: Utility(
        value: formatDateCustom(contact?.dateCreated),
        hint: "Date Created",
      ),
      box2: Utility(
        value: formatDateCustom(contact?.dateModified),
        hint: "Date Modified",
      ),
      onDelete: () => showConfirmationPopup(context,
          detail: "Are you sure you want to delete?"),
      onEdit: () => editContact(context, model: model, row: contact),
      onShare: () => shareContact(context, contact: contact),
    );
  }
}

void shareContact(BuildContext context, {ContactRow contact}) async {
  try {
    String str = "BEGIN:VCARD\n" +
        "VERSION:4.0\n" +
        "N:${contact?.lastName};${contact?.firstName};;;\n" +
        "FN:${(contact?.firstName ?? "") + " " + contact?.lastName}\n" +
        "ORG:Unify CRM\n" +
        "TITLE:Unify Contact\n";
    if (!isNullOrEmpty(contact?.cellPhone?.raw()))
      str +=
          "TEL;TYPE=cell,voice;VALUE=uri:tel:+${contact?.cellPhone?.toString()}\n";
    if (!isNullOrEmpty(contact?.homePhone?.raw()))
      str +=
          "TEL;TYPE=home,voice;VALUE=uri:tel:+${contact?.homePhone?.toString()}\n";
    if (!isNullOrEmpty(contact?.officePhone?.raw()))
      str +=
          "TEL;TYPE=work,voice;VALUE=uri:tel:+${contact?.officePhone?.toString()}\n";
    if (!isNullOrEmpty(contact?.email)) str += "EMAIL:${contact?.email}\n";
    str += "REV:20080424T195243Z\n" + "END:VCARD";

    print("VCF Data: $str");

    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/flutter/test.txt");

    var _fileContents = testFile?.readAsStringSync();

    print("Old File => " + _fileContents);

    print("File Created...");

    testFile.writeAsStringSync(str);

    print("File Updated...");

    var _newContents = testFile?.readAsStringSync();

    print("New File => " + _newContents);

    ShareExtend.share(testFile.path.replaceAll(".txt", ".vcf"), "file");

//    if (!await testFile.exists()) {
//      await testFile.create(recursive: true);
//      testFile.writeAsStringSync(str);
//
////      shareFile(context, file: testFile);
//    }

  } catch (e) {
    print(e);
  }
}
//
//Future<File> writeData(String data) async {
//  final file = await _localFile;
//
//  // Write the file
//  return file.writeAsString('$data');
//}
//
//Future<File> get _localFile async {
//  final path = await _localPath;
//  return new File('$path/contact.vcf');
//}
//
//Future<String> get _localPath async {
//  final directory = await getApplicationDocumentsDirectory();
//
//  return directory.path;
//}
