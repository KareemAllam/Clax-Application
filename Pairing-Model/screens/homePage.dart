import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:paring/widgets/Pair_btn.dart';
import 'package:paring/utils/MapMethod.dart';
import 'package:provider/provider.dart';
//import 'package:location/location.dart';


class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Set<Marker> markers;
  Marker mk1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    markers = Set.from([]);


}



  @override
  Widget build(BuildContext context) {
    final appstate = Provider.of<AppState>(
      context,
      listen: true,
    );
//    setState(() {
//      mk1 = Marker(
//        markerId: MarkerId('1'),
//        position: appstate.initialPosition,
//      );
//      markers.add(mk1);
//    });


    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(title: Text("اختر موقعك"),
      ),
      body: SafeArea(
        child:appstate.initialPosition == null
            ? Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRotatingCircle(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Visibility(
                  visible:appstate.locationServiceActive == false,
                  child: Text("Please enable location services",
                    style: TextStyle(color: Colors.black, fontSize: 18),),
                )
              ],
            )
        )

            :Center(
          child:Stack(
               children: <Widget>[


                 GoogleMap(
                   initialCameraPosition: CameraPosition(
                       target: appstate.initialPosition, zoom: 10.0),
                   onMapCreated: appstate.onCreated,
                   mapType: MapType.normal,
                   compassEnabled: true,
                   markers: markers,
                    myLocationEnabled: true,
                   onCameraMove: appstate.onCameraMove,
                   onTap: (position){
                     Marker mk1 = Marker(
                       markerId: MarkerId('1'),
                       position: position,
                     );

                       print("on tap77777777777");
                       markers.add(mk1);
                       appstate.get_address(position);
                       print("************////////////////////${appstate.locationController}//////////*********************");
                     })



                 ,
                 FloatingActionButton(elevation: 5,
                   backgroundColor: Colors.deepPurple,
                   foregroundColor: Colors.white,
                   child: Icon(Icons.edit_location,),
                   onPressed: () {
                     appstate.get_address(appstate.initialPosition);
                     Marker mk1 = Marker(
                       markerId: MarkerId('1'),
                       position: appstate.initialPosition,
                     );
                     markers.add(mk1);
                   },),

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
                       cursorColor: Theme.of(context).primaryColor,
                       controller: appstate.locationController,
                       decoration: InputDecoration(
                         icon: Container(
                           margin: EdgeInsets.only(left: 20),
                           width: 10,
                           height: 10,
                           child: Icon(

                             Icons.location_on,
                             color:Theme.of(context).primaryColor,
                           ),
                         ),
                         hintText: " موقعك",
                         border: InputBorder.none,
                         contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                       ),
                   onChanged: ( val) {
                     setState(() {

                       // searchAddr = val;
                     });
                   } ),
                   ),
                 ),

                /////////////////////////////////////////////
                 Okbtn("تاكيد","linespage")

,

              ],
          )
        ),
      ),
    );
  }



}
