import 'package:clax/widgets/favourites.dart';
import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'Components/new_trip.dart';

class Tabs extends StatefulWidget {
  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  final List<Map<String, Object>> _pages = [
    {
      'page': NewTrip(),
      'title': 'رحلة جديدة',
    },
    {
      'page': Favourites(),
      'title': 'رحلاتك المفضلة',
    },
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        _pages[_selectedPageIndex]['title'],
        style:
            Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
      )),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white60,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.airline_seat_recline_extra),
            title: Text(
              'رحلة جديدة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.0,
              ),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text(
              'الرحلات المفضلة',
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}