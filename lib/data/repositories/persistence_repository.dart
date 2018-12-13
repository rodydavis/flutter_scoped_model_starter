import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';

import '../classes/auth/auth_module.dart';
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

  // Future<File> saveUIState(UIState state) async {
  //   var data = serializers.serializeWith(UIState.serializer, state);
  //   return await fileStorage.save(json.encode(data));
  // }

  // Future<UIState> loadUIState() async {
  //   String data = await fileStorage.load();
  //   return serializers.deserializeWith(UIState.serializer, json.decode(data));
  // }

  // Future<File> saveDataState(DataState state) async {
  //   var data = serializers.serializeWith(DataState.serializer, state);
  //   return await fileStorage.save(json.encode(data));
  // }

  // Future<DataState> loadDataState() async {
  //   String data = await fileStorage.load();
  //   return serializers.deserializeWith(DataState.serializer, json.decode(data));
  // }

  Future<FileSystemEntity> delete() async {
    return await fileStorage
        .exisits()
        .then((exists) => exists ? fileStorage.delete() : null);
  }

  Future<bool> exists() async {
    return await fileStorage.exisits();
  }
}
