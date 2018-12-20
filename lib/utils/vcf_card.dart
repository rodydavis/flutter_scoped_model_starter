import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:share_extend/share_extend.dart';
import 'package:uuid/uuid.dart';
import 'null_or_empty.dart';
import '../data/classes/general/phone.dart';

void shareContact(BuildContext context) async {
  Contact _info = Contact(
    givenName: "Rody",
    familyName: "Davis",
    phones: [
      Item(label: "home", value: "2054930082"),
      Item(label: "work", value: "8132234321"),
    ],
    emails: [
      Item(label: "home", value: "a@a.co"),
      Item(label: "work", value: "test@alfred.com"),
    ],
  );

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
          var _value = Phone.fromString(_item?.value);
//          str += "TEL;type=${_phone?.label?.toUpperCase()}:${_phone?.value}\n";
          str +=
              "TEL;PREF=${_index.toString()};TYPE=${_item?.label?.toUpperCase()}:${_value.toString()}\n";
          print("Added => Phone ${_item?.label} | ${_value?.toString()}");
        }
        _index++;
      }
    }

    str += "EMAIL;PREF=1;TYPE=work:john@mycompany.com\n";

//    if (_info?.emails != null && _info.emails.isNotEmpty) {
//      int _index = 1;
//      for (var _item in _info.emails) {
//        str +=
//            "EMAIL;PREF=${_index.toString()};TYPE=${_item?.label?.toLowerCase()}:${_item?.value}\n";
//        print("Added => Email ${_item?.label} | $_item");
//        _index++;
//      }
//    }

    str += "REV:20080424T195243Z\n" + "END:VCARD";

//    String str = "BEGIN:VCARD\n";
//    str += "VERSION:4.0\n";
//    str += "N:Doe;John;Philip;Dr.;Jr.\n";
//    str += "FN:Mr. Johny\n";
////    str += "NICKNAME:Phil\n";
////    str += "X-MAIDENNAME:MaidenName\n";
////    str += "X-PHONETIC-FIRST-NAME:PhoneticFirstName\n";
////    str += "X-PHONETIC-MIDDLE-NAME:PhoneticMiddleName\n";
////    str += "X-PHONETIC-LAST-NAME:PhoneticLastName\n";
////    str += "X-PRONUNCIATION-FIRST-NAME:PronunciationFirstName\n";
////    str += "X-PRONUNCIATION-MIDDLE-NAME:PronunciationMiddleName\n";
////    str += "X-PRONUNCIATION-LAST-NAME:PronunciationLastName\n";
//    str += "ORG:My Company\, Inc.\n";
//    str += "TITLE:CEO\n";
////    str += "ROLE:Executive\n";
////    str += "EMAIL;PREF=1;TYPE=work:john@mycompany.com\n";
////    str += "EMAIL;PREF=2;TYPE=home:johndoe@example.com\n";
////    str += "TEL;PREF=1;TYPE=work:1 (234) 567-8901\n";
////    str += "TEL;PREF=2:(123) 123-1234\n";
////    str += "TEL;VALUE=uri;PREF=3:tel:1234567890\n";
////    str +=
////        "ADR;PREF=1;TYPE=work:;;123 Forbes Ave\, Apt 1;San Francisco;CA;12345;USA\n";
////    str += "ADR;PREF=2;TYPE=home:;;456 Home St;Homeland;CA;23456;USA\n";
////    str +=
////        "X-SOCIALPROFILE;PREF=1;TYPE=facebook:http://www.facebook.com/johndoe\n";
////    str += "X-SOCIALPROFILE;PREF=2;TYPE=twitter;x-user=johnie:x-apple:johnie\n";
////    str += "URL;PREF=1;TYPE=internet:http://www.mycompany.com\n";
////    str += "URL;PREF=2;TYPE=personal:http://www.johndoe.com\n";
////    str +=
////        "PHOTO;PREF=1;TYPE=work:https://upload.wikimedia.org/wikipedia/en/8/80/Wikipedia-logo-v2.svg\n";
////    str +=
////        "PHOTO;PREF=2;TYPE=home:data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQAQMAAAAlPW0iAAAABlBMVEUAAAD///+l2Z/dAAAAM0lEQVR4nGP4/5/h/1+G/58ZDrAz3D/McH8yw83NDDeNGe4Ug9C9zwz3gVLMDA/A6P9/AFGGFyjOXZtQAAAAAElFTkSuQmCC\n";
////    str += "BDAY:20000131\n";
////    str += "GENDER:M\n";
////    str +=
////        "NOTE;PREF=1:John Doe has a long and varied history\, being documented on more police files that anyone else.\nReports of his death are alas numerous.\n";
////    str += "NOTE;PREF=2:Another note.\n";
//    str += "REV:20080424T195243Z\n";
//    str += "END:VCARD";

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
