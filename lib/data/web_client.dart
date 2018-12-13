import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import '../data/models/auth_model.dart';

class WebClient {
  const WebClient();

  Future<dynamic> get(String url, {String token, AuthModel auth}) async {
    if (token == null && auth == null) throw ('Auth Model or Token Required');
    final String _token = token ?? auth?.currentUser?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.get,
      auth: auth,
    );

    return json.decode(response.body);
  }

  Future<dynamic> delete(String url, {@required AuthModel auth}) async {
    final String _token = auth?.currentUser?.token ?? "";
    http.Response response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.delete,
      auth: auth,
    );

    return json.decode(response.body);
  }

  Future<dynamic> post(String url, dynamic data,
      {String bodyContentType, String token, AuthModel auth}) async {
    if (token == null && auth == null) throw ('Auth Model or Token Required');
    final String _token = token ?? auth?.currentUser?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      body: data,
      headers: {
        HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.post,
      auth: auth,
    );

    return json.decode(response.body);
  }

  Future<dynamic> put(String url, dynamic data,
      {@required AuthModel auth}) async {
    final String _token = auth?.currentUser?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.put,
      auth: auth,
    );

    return json.decode(response.body);
  }

  Future<http.Response> getHttpReponse(
    String url, {
    dynamic body,
    Map<String, String> headers,
    HttpMethod method = HttpMethod.get,
    AuthModel auth,
  }) async {
    final inner.IOClient _client = getClient();
    http.Response response;
    switch (method) {
      case HttpMethod.post:
        response = await _client.post(
          url,
          body: body,
          headers: headers,
        );
        break;
      case HttpMethod.put:
        response = await _client.put(
          url,
          body: body,
          headers: headers,
        );
        break;
      case HttpMethod.delete:
        response = await _client.delete(
          url,
          headers: headers,
        );
        break;
      case HttpMethod.get:
      default:
        response = await _client.get(
          url,
          headers: headers,
        );
    }

    print("URL: $url");
    print("Body: $body");
    print("Response Code: " + response.statusCode.toString());
    print("Response Body: " + response.body.toString());

    if (response.statusCode >= 400) {
      // if (response.statusCode == 404) return response.body; // Not Found Message
      if (response.statusCode == 401) {
        if (auth != null) {
          await auth.refreshToken();
          final String _token = auth?.currentUser?.token ?? "";
          print(" Second Token => $_token");
          // Retry Request
          response = await getHttpReponse(
            url,
            headers: {
              HttpHeaders.authorizationHeader: "Bearer $_token",
            },
          );
        }
      } // Not Authorized
      throw ('An error occurred: ' + response.body);
    }

    return response;
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

enum HttpMethod { get, post, put, delete }
