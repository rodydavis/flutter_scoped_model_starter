import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'package:uuid/uuid.dart';
import 'null_or_empty.dart';
import '../data/classes/general/phone.dart';

void shareContact(BuildContext context, {Contact contact}) async {
//  Contact _info = Contact(
//    givenName: "Rody",
//    familyName: "Davis",
//    phones: [
//      Item(label: "home", value: "2054930082"),
//      Item(label: "work", value: "8132234321"),
//    ],
//    emails: [
//      Item(label: "home", value: "asred@company.com"),
//      Item(label: "work", value: "test@alfred.com"),
//    ],
//  );

  final Contact _info = contact;

  if (_info != null)
    try {
      String str = "BEGIN:VCARD\n" +
          "VERSION:4.0\n" +
          "N:${_info?.familyName};${_info?.givenName};;;\n" +
          "FN:${(_info?.givenName ?? "") + " " + _info?.familyName}\n" +
          "ORG:Unify CRM\n";
//        "TITLE:Unify Contact\n";

      if (_info?.phones != null && _info.phones.isNotEmpty) {
        int _index = 1;
        for (var _item in _info.phones) {
          if (_item != null) {
            str +=
                "TEL;PREF=${_index.toString()};TYPE=${_item?.label?.toUpperCase()}:${_item?.value}\n";
            print("Added => Phone ${_item?.label} | ${_item?.value}");
          }
          _index++;
        }
      }

      if (_info?.emails != null && _info.emails.isNotEmpty) {
        int _index = 1;
        for (var _item in _info.emails) {
          str +=
              "EMAIL;PREF=${_index.toString()};TYPE=${_item?.label}:${_item?.value}\n";
          print("Added => Email ${_item?.label} | ${_item?.value}");
          _index++;
        }
      }

      str += "REV:20080424T195243Z\n" + "END:VCARD";

      var _id = Uuid();
      var _path = "contact";
      print("VCF Data:\n\n$str");
      Directory dir = await getApplicationDocumentsDirectory();
      final testFile = new File('${dir.path}/flutter/$_path.txt');
      print("File: " + testFile.path);
      testFile.writeAsStringSync(str);
      var _bytes = testFile?.readAsBytesSync();
//    print("New File Bytes => " + _bytes.toString());
      final _vcf = new File('${dir.path}/flutter/$_path.vcf');
      print("VCF Path: " + _vcf.path);
      _vcf.writeAsBytesSync(_bytes);
      if (await _vcf.exists()) {
        ShareExtend.share(_vcf.path, "file");
      }
    } catch (e) {
      print(e);
    }
}
