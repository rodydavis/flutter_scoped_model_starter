import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorage {
  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag, {
    this.getDirectory,
  });

  Future<File> _getLocalFile() async {
    if (getDirectory == null) {
      final dir = await getApplicationDocumentsDirectory();

      return File('${dir.path}/$tag.json');
    }
    final dir = await getDirectory();

    return File('${dir.path}/$tag.json');
  }

  Future<dynamic> load() async {
    final file = await _getLocalFile();
    final contents = await file.readAsString();

    return contents;
  }

  Future<File> save(String data) async {
    final file = await _getLocalFile();

    return file.writeAsString(data);
  }

  Future<FileSystemEntity> delete() async {
    final file = await _getLocalFile();

    return file.delete();
  }

  Future<bool> exisits() async {
    final file = await _getLocalFile();

    return file.exists();
  }
}
