
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Lines {
  final String fees;
  final String line;


  Lines({this.fees, this.line});

  factory Lines.fromJson(Map<String, dynamic> json) {
    return Lines(
      fees: json['fees'],
      line: json['line'],

    );
  }
}

class DataListView extends StatefulWidget {


  @override
  _DataListViewState createState() => _DataListViewState();
}

 class _DataListViewState extends State<DataListView> {


  Future <List<Lines>> Data;


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Lines>>(
future: _fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Lines> data = snapshot.data;
          return _dataListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        return Text("Wait");
      },
    );
  }


    Future<List<Lines>> _fetchData() async {

    final jobsListAPIUrl = 'http://10.0.2.2:3000/api/user/station/';
    Map<String, String> headers = {"Content-type": "application/json"};
    String j = ' {"location" : {"longitude": 200, "latitude":300 }}';
    final response = await http.post(jobsListAPIUrl,headers: headers,body: j);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((x) => new Lines.fromJson(x)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }


//  Future<List<Lines>> _fetchData()  async {
//    //  var send = {{'latitude': initialPosition.latitude}, {'longitude': initialPosition.longitude}};
//
//    var uri = Uri(port: 3000,
//        scheme: 'http',
//        host: '10.0.2.2',
//        path: "api/user/station/");
//    print("http${uri}");
//   // String js= {"longitude": 200, "latitude":300 };
//    Map<String, String> headers = {"Content-type": "application/json"};
//    String j = ' {"location" : {"longitude": 200, "latitude":300 }}';
//    print("------------------------open------------------------");
//    await http.post(Uri.decodeFull((uri.toString())),headers: headers, body:j
//
//    ).then((response) {
//      print("------------------------then------------------------");
//      List  jsonResponse = json.decode(response.body);
//      print("'''''''''''''''''''''''''''${jsonResponse.map<Lines>((json) => Lines.fromJson(json)).toList()}''''''''''''''''''");
//      print("********************${response.body}*****************");
//      print("------------------------DONE------------------------");
//      return jsonResponse.map((x) => new Lines.fromJson(x)).toList();
//      });
//
//
//  }



//  Future<List<Lines>> _fetchData() async {
//    var jobsListAPIUrl = Uri(port: 3000,
//        scheme: 'http',
//        host: '192.168.1.30',
//        path: "api/user/station/");
//    print("////////////////////////");
//
//     final response = await http.get(jobsListAPIUrl);
//    print(response);
//    if (response.statusCode == 200) {
//      List jsonResponse = json.decode(response.body);
//      print("********************${response.body}*****************");
//      print("------------------------DONE------------------------");
//      return jsonResponse.map((job) => new Lines.fromJson(job)).toList();
//    } else {
//      print("-------");
//      throw Exception('Failed to load jobs from API');
//    }
//  }

  ListView _dataListView(data) {
print("555555555555555555555555${data}555555555555");
    return ListView.builder(

        itemCount: data.length,

        itemBuilder: (context, index) {

          return _tile(data[index].fees,data[index].line);
        });
  }

  ListTile _tile(String fees,String line) => ListTile(
    title: Text(fees,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),leading: Text(line,style: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 20
  )

  ),


  );


}
