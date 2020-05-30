import 'package:clax/providers/CurrentTrip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfo extends StatefulWidget {
  @override
  _DriverInfoState createState() => _DriverInfoState();
}

class _DriverInfoState extends State<DriverInfo> {
  Map<String, dynamic> _driverInfo;

  void didChangeDependencies() {
    super.didChangeDependencies();
    _driverInfo = (Provider.of<CurrentTripProvider>(context).currentDriverInfo);
  }

  ImageProvider<dynamic> image() {
    try {
      return NetworkImage(_driverInfo['driver_info']['img']);
    } catch (_) {
      return AssetImage('assets/images/404.png');
    }
  }

  Widget pieceOfInfo(String title, String subtitle, IconData icon) => Row(
        children: <Widget>[
          Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(color: Colors.grey),
                strutStyle: StrutStyle(forceStrutHeight: true),
              ),
              SizedBox(height: 5),
              Text(
                subtitle,
                strutStyle: StrutStyle(forceStrutHeight: true),
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.black87, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: double.infinity,
          child: Row(children: <Widget>[
            Icon(Icons.info, color: Colors.white),
            SizedBox(width: 10),
            Text("معلومات عن السائق",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(color: Colors.white))
          ]),
          color: Colors.deepPurple,
        ),
        _driverInfo == null
            ? Container(
                height: 200,
                child: SpinKitCircle(
                    color: Theme.of(context).primaryColor, size: 50))
            : Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(children: <Widget>[
                  CircleAvatar(
                    backgroundImage: image(),
                    backgroundColor: Colors.transparent,
                    radius: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // SizedBox(width: 20),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      pieceOfInfo(
                          "الأسم",
                          '${_driverInfo['driver_info']['name']['first']} ${_driverInfo['driver_info']['name']['last']}',
                          Icons.person),
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () => launch(
                            "tel://${_driverInfo['driver_info']['phone']}"),
                        child: pieceOfInfo("رقم الهاتف",
                            _driverInfo['driver_info']['phone'], Icons.call),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      pieceOfInfo("رقم الميكروباص",
                          _driverInfo['car']["number"], Icons.directions_bus),
                      SizedBox(height: 10),
                      pieceOfInfo("لون المكروباص", _driverInfo['car']["color"],
                          Icons.format_paint)
                    ],
                  )
                ]),
              )
      ],
    );
  }
}
