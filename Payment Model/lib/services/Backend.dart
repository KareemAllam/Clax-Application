import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

Map<String, String> configHeaders = {
  'x-login-token':
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTYyYmVkOGUzNzgwNzA4Njg1MTNlODAiLCJpc19wYXNzZW5nZXIiOnRydWUsInN0cmlwZUlkIjoiY3VzX0d3OGFLdzFzemlHTDl4IiwiaWF0IjoxNTg1ODEwNDczLCJleHAiOjE1ODYzMjg4NzN9.4_RXBLshe4OrFyv0KlzQAuBWvl_ybHIITwySyGzIWfA'
};

class Api {
  static const String BaseUrl = 'http://192.168.1.2:3000/api/';

  static Future<http.Response> get(url) async {
    try {
      return await http
          .get(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 404);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> post(String url, reqBody) async {
    try {
      return await http
          .post(BaseUrl + url, headers: configHeaders, body: reqBody)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 404);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> put(url, reqBody) async {
    try {
      return await http
          .put(BaseUrl + url, headers: configHeaders, body: reqBody)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 404);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> delete(url, reqBody) async {
    try {
      return await http
          .delete(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 404);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }
}

Future sleep(cb) {
  return new Future.delayed(const Duration(seconds: 1), () => cb());
}
