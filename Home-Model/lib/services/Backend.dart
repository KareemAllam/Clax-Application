// import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;

Map<String, String> configHeaders = {
  'x-login-token':
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZTYyYmUyY2UzNzgwNzA4Njg1MTNlN2YiLCJzdHJpcGVJZCI6ImN1c19Hdzd4VDloSENNaU1DQSIsImlzX3Bhc3NlbmdlciI6dHJ1ZX0.93az5OoEAsR-GPyZ6myx7m-82N0rd9eoa9Wf2iTC2lA'
};

class Api {
  static const String BaseUrl = 'http://192.168.1.2:3000/api/';

  static Future<http.Response> get(url) async {
    try {
      // api/user/get
      return await http
          .get(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      print("Server is Down");
      return http.Response('T', 400);
    } on SocketException {
      print("SocketException occured");
      return http.Response('NIC', 400);
    } on Exception catch (_) {
      print("Exception occured");
      return http.Response('NIC', 400);
    } catch (error) {
      print("error occured");
      return http.Response('NIC', 400);
    }
  }

  static Future<http.Response> post(url, reqBody) async {
    try {
      return await http
          .post(BaseUrl + url, body: reqBody, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      print("TimeoutException occured");
      return http.Response('T', 408);
    } on SocketException catch (_) {
      print("SocketException occured");
      return http.Response('NIC', 400);
    } on Exception {
      print("Exception occured");
      return http.Response('NIC', 404);
    } catch (error) {
      return http.Response('NIC', 400);
    }
  }

  static Future<http.Response> put(String url, reqBody) async {
    try {
      return await http
          .put(
            BaseUrl + url,
            body: reqBody,
            headers: configHeaders,
          )
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
    } on SocketException {
      return http.Response('NIC', 404);
    } on Exception {
      return http.Response('NIC', 404);
    } catch (error) {
      print(error);
      return http.Response('NIC', 400);
    }
  }

  static Future<http.Response> delete(url, reqBody) async {
    try {
      return await http
          .delete(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
    } on SocketException {
      return http.Response('NIC', 400);
    } on Exception {
      return http.Response('NIC', 404);
    } catch (error) {
      return http.Response('NIC', 400);
    }
  }
}

Future sleep(cb) {
  return new Future.delayed(const Duration(seconds: 1), () => cb());
}

// Example of Usage
// Hager: Raid, I need informaiton about id: 111
// Raid: Name = Hager, Email:anonymous@gmail.com ==> statusCode = 200
// Raid: No account with id 111 ==> statusCode = 404
// Raid: --- => statusCode = 400
//// TimeoutExecption => Server is down
//// SocectException => Sever doesn't have accee to internet
