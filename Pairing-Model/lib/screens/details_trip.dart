import 'package:flutter/material.dart';
import 'package:paring/main.dart';
import 'package:paring/widgets/action_btn.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:paring/utils/MapMethod.dart';
import 'package:provider/provider.dart';

class Details_trip extends StatefulWidget {
  @override
  _Details_tripState createState() => _Details_tripState();
}

class _Details_tripState extends State<Details_trip> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => AppState()),
        ],
        child: Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(" الرحلة"),
            ),
            body: Center(
              child: Stack(
                children: <Widget>[
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                        target: AppState().initialPosition, zoom: 10.0),
                    onMapCreated: AppState().onCreated,
                    myLocationEnabled: true,
                    mapType: MapType.normal,
                    compassEnabled: true,
                    markers: AppState().markers,
                  ),
                  Positioned(
                    top: 50.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: AppState().locationController,
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            width: 10,
                            height: 10,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "pick up",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 105.0,
                    right: 15.0,
                    left: 15.0,
                    child: Container(
                      height: 50.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: AppState().destinationController,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (value) {

                        },
                        decoration: InputDecoration(
                          icon: Container(
                            margin: EdgeInsets.only(left: 20, top: 5),
                            width: 10,
                            height: 10,
                            child: Icon(
                              Icons.local_taxi,
                              color: Colors.black,
                            ),
                          ),
                          hintText: "destination?",
                          border: InputBorder.none,
                          contentPadding:
                              EdgeInsets.only(left: 15.0, top: 16.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 200.0,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/img.jpg',
                            height: 50,
                            width: 50,
                          ),
                          Text(
                            "Driver Data",
                            style: Theme.of(context).textTheme.title,
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 5.0),
                              blurRadius: 10,
                              spreadRadius: 3)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
    /* Container(
              //color:  Theme.of(context).primaryColor,
                  child:
                  Align(
                    alignment: Alignment.bottomCenter,
                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.end,

                      children: <Widget>[
                    Text("Driver Data"),
                    Image.asset(
                      'assets/images/img.jpg',width:50,height: 50,)

                  ],)
                    ,)

                  )*/
  }
}

Widget driver_details(BuildContext context) {}
