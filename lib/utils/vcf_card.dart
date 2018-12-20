import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<File> generateVCARD(BuildContext context, {Contact contact}) async {
  final Contact _info = contact;

  if (_info != null)
    try {
      String str = "";
      str += "BEGIN:VCARD\n";
      str += "VERSION:4.0\n";
      str += "N:${_info?.familyName};${_info?.givenName};;;\n";
      str += "FN:${(_info?.givenName ?? "") + " " + _info?.familyName}\n";
      if (_info?.company != null && _info.company.isNotEmpty)
        str += "ORG:${_info?.company}\n";
      if (_info?.jobTitle != null && _info.jobTitle.isNotEmpty)
        str += "TITLE:${_info?.jobTitle}\n";

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

//      if (_info?.postalAddresses != null && _info.postalAddresses.isNotEmpty) {
//        int _index = 1;
//        for (var _item in _info.postalAddresses) {
//          str +=
//          "EMAIL;PREF=${_index.toString()};TYPE=${_item?.label}:${_item?.value}\n";
//          print("Added => Email ${_item?.label} | ${_item?.value}");
//          _index++;
//        }
//      }

      str += "REV:20080424T195243Z\n" + "END:VCARD";

      // -- Write to File --
      var _path = "contact";
      print("VCF Data:\n\n$str");
      Directory dir = await getApplicationDocumentsDirectory();
      final testFile = new File('${dir.path}/flutter/$_path.txt');
      print("File: " + testFile.path);
      testFile.writeAsStringSync(str);
      var _bytes = testFile?.readAsBytesSync();
      final _vcf = new File('${dir.path}/flutter/$_path.vcf');
      print("VCF Path: " + _vcf.path);
      _vcf.writeAsBytesSync(_bytes);
      return _vcf;
    } catch (e) {
      print("Error Creating VCF File $e");
      return null;
    }
}
