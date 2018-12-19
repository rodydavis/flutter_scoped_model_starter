import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'dart:io';

import 'package:share_extend/share_extend.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

enum ShareTypes { text, image, file }

class ShareButton extends StatelessWidget {
  final dynamic data;
  final bool select;
  final ShareTypes type;

  ShareButton({this.data, this.type = ShareTypes.text, this.select = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.share),
      onPressed: () {
        switch (type) {
          case ShareTypes.text:
            shareText(context, text: data, select: select);
            break;
          case ShareTypes.file:
            shareFile(context, file: data, select: select);
            break;
          case ShareTypes.image:
            shareImage(context, image: data, select: select);
            break;
        }
      },
    );
  }
}

void shareImage(BuildContext context, {bool select = false, File image}) async {
  if (select) {
    File f = await ImagePicker.pickImage(source: ImageSource.gallery);
    ShareExtend.share(f.path, "image");
  } else {
    File f = image;
    ShareExtend.share(f.path, "image");
  }
}

void shareText(BuildContext context,
    {String text = "", bool select = false}) async {
  if (text != null && text.isNotEmpty) {
//    ShareExtend.share(text, "text");
    final RenderBox box = context.findRenderObject();
    Share.share(
      text,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}

void shareFile(BuildContext context, {bool select = false, File file}) async {
  if (select) {
    Directory dir = await getApplicationDocumentsDirectory();
    File testFile = new File("${dir.path}/flutter/test.txt");
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  } else {
    File testFile = file;
    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
  }
}
