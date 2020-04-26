// Flutter's Material Components
import 'package:flutter/material.dart';
// Components
import 'package:clax/screens/Home/Components/History.dart';
//import 'package:clax/screens/Home/Components/scheduled.dart';
// Widgets
import 'package:clax/widgets/drawer.dart';

class Rides extends StatefulWidget {
  static const routeName = '/Rahalatk';

  @override
  _RidesState createState() => _RidesState();
}

class _RidesState extends State<Rides> {
  bool fetched = false;
  List<dynamic> trips;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'رحلاتك',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
            // bottom:
            // TabBar(
            //   tabs: <Widget>[
            //     // Tab(
            //     //   icon: Icon(
            //     //     Icons.directions_bus,
            //     //   ),
            //     //   text: 'القادمة',
            //     // ),
            //     Tab(
            //       icon: Icon(
            //         Icons.history,
            //       ),
            //       text: 'السابقة',
            //     ),
            //   ],
            // ),
          ),
          drawer: MainDrawer(),
          body: History()
          // TabBarView(
          //   children: <Widget>[
          //     // Scheduled(),
          //     History(),
          //   ],
          // ),
          ),
    );
  }
}
