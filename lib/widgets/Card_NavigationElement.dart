import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/card.dart';

class NavigationCard extends StatelessWidget {
  final CardModel card;
  NavigationCard({this.card});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double cardHeight = height * 0.11;
    // final double borderRadius = width * 0.02;
    final double padding = width * 0.04;
    return
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: padding / 2, horizontal: padding),
        //   child:
        Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: width,
          height: cardHeight,
          child: Material(
            // elevation: 2.0,
            // borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
            color: Theme.of(context).backgroundColor,
            child: InkWell(
              // borderRadius: BorderRadius.all(Radius.circular(width * 0.01)),
              onTap: () {
                if (card.screen.contains(':') == true)
                  launch(card.screen);
                else
                  Navigator.of(context).pushNamed(card.screen);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: padding * 0.6, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Icon(card.icon,
                          color: Theme.of(context).primaryColor),
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              card.title,
                              strutStyle: StrutStyle(forceStrutHeight: true),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16),
                            ),
                            Text(
                              card.description,
                              style: TextStyle(
                                  color: Theme.of(context).secondaryHeaderColor,
                                  fontFamily: 'Cairo',
                                  fontSize: 14),
                            ),
                          ]),
                    ),
                    Expanded(
                      flex: 2,
                      child: Icon(Icons.keyboard_arrow_left),
                    )
                  ],
                ),
              ),
            ),
            // ),
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
