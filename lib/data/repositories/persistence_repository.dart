import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../classes/auth/auth_module.dart';
import '../classes/contacts/contact_module.dart';
import '../classes/tasks/task_module.dart';
import '../classes/app/theme.dart';
import '../file_storage.dart';

class PersistenceRepository {
  final FileStorage fileStorage;

  const PersistenceRepository({
    @required this.fileStorage,
  });

  Future<File> saveAuthState(AuthModule state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<AuthModule> loadAuthState() async {
    String data = await fileStorage.load();
    return AuthModule.fromJson(json.decode(data));
  }

  Future<File> saveThemeState(ThemeModule state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<ThemeModule> loadThemeState() async {
    String data = await fileStorage.load();
    return ThemeModule.fromJson(json.decode(data));
  }

  // STARTER: state - do not remove comment

  Future<File> saveContactsState(ContactModule state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<ContactModule> loadContactsState() async {
    String data = await fileStorage.load();
    return ContactModule.fromJson(json.decode(data));
  }

  Future<File> saveTasksState(TaskModule state) async {
    var data = state.toJson();
    return await fileStorage.save(json.encode(data));
  }

  Future<TaskModule> loadTasksState() async {
    String data = await fileStorage.load();
    return TaskModule.fromJson(json.decode(data));
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
