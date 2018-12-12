import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../models/auth/model.dart';
import '../models/contact/list.dart';
import '../models/paging_model.dart';
import '../models/search_model.dart';
import '../web_client.dart';
import '../models/contact/info.dart';
import '../../utils/null_or_empty.dart';

class ContactRepository {
  final WebClient webClient;

  const ContactRepository({
    this.webClient = const WebClient(),
  });

  Future<ContactResult> loadList(AuthModel auth,
      {@required PagingModel paging, SearchModel search}) async {
    dynamic _response;

    // search = SearchModel(search: "Prospect", filters: [5]);

    // -- Search By Filters --
    if (search != null && search.search.toString().isNotEmpty) {
      final response = await webClient.post(
        kApiUrl + '/search/contacts/${paging.rows}/${paging.page}',
        json.encode(search),
        token: auth?.currentUser?.token,
      );

      _response = response;
    } else {
      // -- Get List --
      final response = await webClient.get(
        kApiUrl + '/contacts/${paging.rows}/${paging.page}',
        token: auth?.currentUser?.token,
      );
      _response = response;
    }

    var result = ContactResult.fromJson(_response);

    return result;
  }

  Future<ContactDetailsResult> getInfo(AuthModel auth,
      {@required String id}) async {
    dynamic _response;

    // -- Get List --
    final response = await webClient.get(
      kApiUrl + '/contacts/info/$id',
      token: auth?.currentUser?.token,
    );
    _response = response;

    var result = ContactDetailsResult.fromJson(_response);

    return result;
  }

  Future<bool> deleteContact(AuthModel auth, {@required String id}) async {
    var url = kApiUrl + '/contacts/info/' + id.toString();
    var response;
    response = await webClient.delete(
      url,
      token: auth?.currentUser?.token,
    );
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }

  Future<bool> saveData(AuthModel auth,
      {@required ContactDetails contact, String id}) async {
    var data = contact.toJson();
    print(data);
    var response;

    if (isNullOrEmpty(id)) {
      print("Creating Contact...");
      response = await webClient.post(
        kApiUrl + '/contacts/add',
        json.encode(data),
        token: auth?.currentUser?.token,
      );
      print(response);
      if (response["Status"].toString().contains("Success")) return true;
      return false;
    } else {
      print("Editing Contact... $id");
      var url = kApiUrl + '/contacts/info/' + id.toString();
      response = await webClient.put(
        url,
        json.encode(data),
        token: auth?.currentUser?.token,
      );
      print(response);
      if (response["Status"].toString().contains("Success")) return true;
      return false;
    }
  }

  Future<bool> importData(AuthModel auth,
      {@required List<ContactDetails> contacts}) async {
    var data = json.encode(contacts);
    print(data);
    var response;

    response = await webClient.post(
      kApiUrl + '/contacts/import',
      data,
      token: auth?.currentUser?.token,
    );
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }
}
