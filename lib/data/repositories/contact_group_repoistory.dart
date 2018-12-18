import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../classes/app/paging.dart';
import '../classes/unify/contact_group.dart';
import '../classes/unify/response.dart';
import '../models/auth_model.dart';
import '../web_client.dart';

class ContactGroupRepository {
  final WebClient webClient;

  const ContactGroupRepository({
    this.webClient = const WebClient(),
  });
  // -- Contact Groups --
  Future<ResponseMessage> getContactGroups(AuthModel auth) async {
    dynamic _response;

    // -- Get List --
    final response = await webClient
        .get(kApiUrl + '/contacts/contact_groups?totals=true', auth: auth);
    _response = response;

    var result = ResponseMessage.fromJson(_response);

    return result;
  }

  Future<bool> deleteContactGroup(AuthModel auth, {@required String id}) async {
    var url = kApiUrl + '/contacts/contact_groups/' + id.toString();
    var response;
    response = await webClient.delete(url, auth: auth);
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }

  Future<bool> editContactGroup(AuthModel auth,
      {@required String id, @required String name}) async {
    var url = kApiUrl + '/contacts/contact_groups/' + id.toString();
    var data = json.encode(ContactGroup(name: name));
    var response;
    response = await webClient.put(url, data, auth: auth);
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }

  Future<bool> addContactGroup(AuthModel auth, {@required String name}) async {
    var url = kApiUrl + '/contacts/contact_groups';
    var data = json.encode(ContactGroup(name: name));
    var response;
    response = await webClient.post(url, data, auth: auth);
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }

  // -- Contact Groups --
  Future<ResponseMessage> getContactsFromGroup(AuthModel auth,
      {@required String id, @required Paging paging}) async {
    dynamic _response;

    // -- Get List --
    final response = await webClient.get(
        kApiUrl +
            "/contacts/contact_groups/$id/list?rows=${paging.rows}&page=${paging.page}",
        auth: auth);
    _response = response;

    var result = ResponseMessage.fromJson(_response);

    return result;
  }
}
