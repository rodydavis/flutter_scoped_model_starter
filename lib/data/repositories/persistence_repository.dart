import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../classes/app/settings.dart';
import '../classes/auth/auth_module.dart';
import '../file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveSettingsState(AppSettings state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<AppSettings> loadSettingsState() async {
    String data = await fileStorage.load();
    return AppSettings.fromJson(json.decode(data));
  }

  Future<File> saveAuthState(AuthModule state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<AuthModule> loadAuthState() async {
    String data = await fileStorage.load();
    return AuthModule.fromJson(json.decode(data));
  }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exisits()
        .then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exisits();
  }
}
