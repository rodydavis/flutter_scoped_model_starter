import '../web_client.dart';
import '../../constants.dart';
import '../models/paging_model.dart';
import 'package:flutter/foundation.dart';
import '../models/search_model.dart';
import '../models/crud_model.dart';
import '../models/auth.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

class CRUDRepository {
  final WebClient webClient;

  const CRUDRepository({
    this.webClient = const WebClient(),
  });

  Future<List<CRUDObject>> loadList(
    AuthModel auth, {
    @required PagingModel paging,
    SearchModel search,
  }) async {
    dynamic _response;

    // search = SearchModel(search: "Prospect", filters: [5]);

    // -- Search By Filters --
    if (search != null && search.search.toString().isNotEmpty) {
      final response = await webClient.post(
        kApiUrl + '/search/contacts/${paging.rows}/${paging.page}',
        json.encode(search),
        token: auth?.token,
      );
      _response = response;

      // -- Get List --
    } else {
      final response = await webClient.get(
        kApiUrl + '/contacts/${paging.rows}/${paging.page}',
        token: auth?.token,
      );
      _response = response;
    }

    // -- Not Found --
    if (_response.toString().contains("No Contacts Found")) {
      return new List<CRUDObject>();
    }

    // -- Create List of Contacts --
    // var list = new List<CRUDObject>(_response.map((contact) {
    //   return serializers.deserializeWith(ContactEntity.serializer, contact);
    // }));

    var list = [];

    return list;
  }

  Future deleteContact(AuthModel auth, String id) async {
    var url = kApiUrl + '/contacts/info/' + id.toString();
    var response;
    response = await webClient.delete(url, token: auth?.token);
    print(response);
  }

  // Future saveData(AuthModel auth, ContactEntity contact) async {
  //   var data = serializers.serializeWith(ContactEntity.serializer, contact);
  //   var response;

  //   if (contact.isNew) {
  //     response =
  //         await webClient.post(kApiUrl + '/contacts/new', json.encode(data));
  //   } else {
  //     var url = kApiUrl + '/contacts/info/' + contact.id.toString();
  //     response =
  //         await webClient.put(url, json.encode(data), token: auth?.token);
  //   }

  //   return serializers.deserializeWith(ContactEntity.serializer, response);
  // }
}
