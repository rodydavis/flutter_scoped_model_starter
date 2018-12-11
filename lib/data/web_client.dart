import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;

class WebClient {
  const WebClient();

  Future<dynamic> get(String url, {@required String token}) async {
    final http.Response response = await getClient().get(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    print("URL: $url");
    print("Token: $token");
    print("Response Code: " + response.statusCode.toString());
    print("Response Body: " + response.body.toString());

    if (response.statusCode >= 400) {
      if (response.statusCode == 404) return response.body; // Not Found Message
      throw ('An error occurred: ' + response.body);
    }

    return json.decode(response.body);
  }

  Future<dynamic> delete(String url, {@required String token}) async {
    final http.Response response = await getClient().delete(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    print("URL: $url");
    print("Token: $token");
    print("Response Code: " + response.statusCode.toString());
    print("Response Body: " + response.body.toString());

    if (response.statusCode >= 400) {
      if (response.statusCode == 404) return response.body; // Not Found Message
      throw ('An error occurred: ' + response.body);
    }

    return json.decode(response.body);
  }

  Future<dynamic> post(
    String url,
    dynamic data, {
    String bodyContentType,
    String token,
  }) async {
    final http.Response response = await getClient().post(
      url,
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );
    print("URL: $url");
    print("Headers: $bodyContentType");
    print("Body: $data");
    print("Token: $token");
    print("Response Code: " + response.statusCode.toString());
    print("Response Body: " + response.body.toString());

    if (response.statusCode >= 400) {
      if (response.statusCode == 404) return response.body; // Not Found Message
      throw ('An error occurred: ' + response.body);
    }

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  Future<dynamic> put(String url, dynamic data, {String token}) async {
    final http.Response response = await getClient().put(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $token",
      },
    );

    if (response.statusCode >= 400) {
      throw ('An error occurred: ' + response.body);
    }

    try {
      final jsonResponse = json.decode(response.body);
      return jsonResponse;
    } catch (exception) {
      print(response.body);
      throw ('An error occurred');
    }
  }

  inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
}
