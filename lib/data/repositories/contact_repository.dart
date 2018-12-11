import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../constants.dart';
import '../models/auth/model.dart';
import '../models/contact/list.dart';
import '../models/paging_model.dart';
import '../models/search_model.dart';
import '../web_client.dart';

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

  Future deleteContact(AuthModel auth, String id) async {
    var url = kApiUrl + '/contacts/info/' + id.toString();
    var response;
    response = await webClient.delete(
      url,
      token: auth?.currentUser?.token,
    );
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
