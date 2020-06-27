import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
bool log_bool = false;



Future<bool> loginReq(String user , String pass) async {
  var uri = Uri(port: 3000, scheme: 'http', host: '192.168.1.5',path: "api/user/");
  await http.post(Uri.decodeFull((uri.toString())), body: {

  }).then((value) {
    print('Sccessed...');
    print(value);
  });
  return log_bool;
}