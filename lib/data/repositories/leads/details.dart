import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../constants.dart';
import '../../../utils/null_or_empty.dart';
import '../../classes/leads/lead_details.dart';
import '../../classes/unify/response.dart';
import '../../models/auth_model.dart';
import '../../web_client.dart';

class LeadDetailsRepository {
  final WebClient webClient;

  const LeadDetailsRepository({
    this.webClient = const WebClient(),
  });

  Future<ResponseMessage> getLead(AuthModel auth, {@required String id}) async {
    dynamic _response;

    // -- Get List --
    final response =
        await webClient.get(kApiUrl + '/leads/info/$id', auth: auth);
    _response = response;

    var result = ResponseMessage.fromJson(_response);

    return result;
  }

  Future<bool> deleteLead(AuthModel auth, {@required String id}) async {
    var url = kApiUrl + '/leads/info/' + id.toString();
    var response;
    response = await webClient.delete(url, auth: auth);
    print(response);
    if (response["Status"].toString().contains("Success")) return true;
    return false;
  }

  Future<bool> saveLead(AuthModel auth,
      {@required LeadDetails lead, String id}) async {
    var data = lead.toJson();
    print(data);
    var response;

    if (isNullOrEmpty(id)) {
      print("Creating Lead...");
      response = await webClient.post(kApiUrl + '/leads/add', json.encode(data),
          auth: auth);
      print(response);
      if (response["Status"].toString().contains("Success")) return true;
      return false;
    } else {
      print("Editing Lead... $id");
      var url = kApiUrl + '/leads/info/' + id.toString();
      response = await webClient.put(url, json.encode(data), auth: auth);
      print(response);
      if (response["Status"].toString().contains("Success")) return true;
      return false;
    }
  }

  // Future<bool> importData(AuthModel auth,
  //     {@required List<ContactDetails> leads}) async {
  //   var data = json.encode(leads);
  //   print(data);
  //   var response;

  //   response =
  //       await webClient.post(kApiUrl + '/leads/batch/import', data, auth: auth);
  //   print(response);
  //   if (response["Status"].toString().contains("Success")) return true;
  //   return false;
  // }
}
