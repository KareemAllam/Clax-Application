//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:paring/screens/test_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paring/utils/MapMethod.dart';
import 'package:provider/provider.dart';
import 'package:paring/screens/StationPage.dart';
import 'package:paring/screens/homePage.dart';
import 'package:paring/screens/LinesPage.dart';
import 'package:paring/screens/details_trip.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: AppState(),
          ),
        ],
    child:
        MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar', 'AE')
            // OR Locale('ar', 'AE') OR Other RTL locales
          ],

          title: 'Clax',
          theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              accentColor: Colors.grey,
              backgroundColor: Colors.white,
              hintColor: Colors.black,
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  )),
              appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
              )),
          initialRoute: 'home',
          routes: {
            'home': (context) => MapPage(),
            'linespage': (context) => LinesPage(),
            'stationpage': (context) => StationPage(),
            'detailstrip': (context) => Details_trip(),
            //'test':(context)=>App()
          },
        )  );

//                create: (context) => AppState(),
//          child:  MaterialApp(
//            localizationsDelegates: [
//                GlobalMaterialLocalizations.delegate,
//                GlobalWidgetsLocalizations.delegate,
//            ],
//            supportedLocales: [
//                Locale('ar', 'AE')
//                // OR Locale('ar', 'AE') OR Other RTL locales
//            ],
//            theme: ThemeData(
//                primarySwatch: Colors.deepPurple,
//                accentColor: Colors.grey,
//                backgroundColor: Colors.white,
//                hintColor: Colors.black,
//                textTheme: ThemeData.light().textTheme.copyWith(
//                    title: TextStyle(
//                        color: Colors.black,
//                        fontWeight: FontWeight.bold,
//                        fontSize: 18,
//                    )),
//                appBarTheme: AppBarTheme(
//                    textTheme: ThemeData.light().textTheme.copyWith(
//                        title: TextStyle(
//                            fontFamily: 'Cairo',
//                            fontSize: 20,
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold,
//                        ),
//                    ),
//                )),
//            home: MapPage(),
//            initialRoute: 'home',
//            routes: {
//                'home': (context) => MapPage(),
//                'linespage': (context) => LinesPage(),
//                'stationpage': (context) => StationPage(),
//                'detailstrip':(context)=>Details_trip(),
//                //'test':(context)=>App()
//            },
//        )
  }
}
