// Dart & Other Packages
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static Map<String, String> configHeaders;
  // static const String BaseUrl = 'http://192.168.1.2:3000/api/';
  static const String BaseUrl = 'https://www.clax-egyp.me/api/';

  static Future<http.Response> get(url) async {
    // Retreive Token from Cache
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    configHeaders = {'x-login-token': _prefs.getString("loginToken")};
    try {
      return await http
          .get(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> post(String url, dynamic reqBody,
      {bool stringDynamic = false}) async {
    // Retreive Token from Cache

    SharedPreferences _prefs = await SharedPreferences.getInstance();
    configHeaders = {'x-login-token': _prefs.getString("loginToken") ?? ""};

    if (stringDynamic == true)
      configHeaders['Content-Type'] = 'application/json';
    try {
      return await http
          .post(BaseUrl + url, headers: configHeaders, body: reqBody ?? {})
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> put(url, {dynamic reqBody}) async {
    // Retreive Token from Cache
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    configHeaders = {'x-login-token': _prefs.getString("loginToken")};
    try {
      return await http
          .put(BaseUrl + url, headers: configHeaders, body: reqBody)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
    } on SocketException catch (_) {
      return http.Response('NIC', 408);
    } on Exception {
      return http.Response('NIC', 408);
    } catch (error) {
      print(error);
      return http.Response('T', 408);
    }
  }

  static Future<http.Response> delete(url) async {
    // Retreive Token from Cache
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    configHeaders = {'x-login-token': _prefs.getString("loginToken")};
    try {
      return await http
          .delete(BaseUrl + url, headers: configHeaders)
          .timeout(Duration(seconds: 5));
    } on TimeoutException {
      return http.Response('T', 408);
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
