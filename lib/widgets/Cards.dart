// Flutter's Material Components
import 'package:flutter/material.dart';
// Dart & Other Pacakges
import 'package:url_launcher/url_launcher.dart';
// Models
import 'package:clax/models/Card.dart';

class Cards {
  Cards._();

  static Widget bottomSheetCard(
      BuildContext context, String title, Function onPressed,
      {AssetImage img, IconData icon}) {
    assert(
        img == null || icon == null, 'Cannot provide both a img and a icon\n');
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          icon == null
              ? Image(image: img, height: 24)
              : Icon(
                  icon,
                  color: Theme.of(context).primaryColor,
                ),
          SizedBox(width: 16),
          Text(title, style: Theme.of(context).textTheme.subtitle2)
        ],
      ),
    );
  }

  /// <image>
  static Widget destinationCard(BuildContext context,
      {String fromTo, String cost}) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
        child: ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.directions_bus,
                color: Theme.of(context).textTheme.subtitle1.color),
          ),
          title: Text(
            fromTo,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          trailing: Text(
            cost.toString(),
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ),
    );
  }

  /// Navigation Card for menu usage
  static Widget navigationCard(BuildContext context, {CardModel card}) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double cardHeight = height * 0.11;
    final double padding = width * 0.04;
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: width,
          height: cardHeight,
          child: Material(
            color: Theme.of(context).backgroundColor,
            child: InkWell(
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

  /// Switch Build Tile
  static Widget switchListTile({
    BuildContext context,
    String title,
    String description,
    bool currentValue,
    Function updatedValue,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.black12))),
      child: SwitchListTile(
        activeColor: Theme.of(context).primaryColor,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          description,
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.black38),
        ),
        value: currentValue,
        onChanged: updatedValue,
      ),
    );
  }

  /// buildListTile1
  static Widget listTile1(BuildContext context,
      {String title, Function tapHandler}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor))),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
        ),
        onTap: tapHandler,
        trailing: Icon(Icons.arrow_right, size: 22),
      ),
    );
  }

  /// List Tile
  static Widget listTile(BuildContext context,
      {String title, IconData icon, Function tapHandler}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(
                  color: Theme.of(context).scaffoldBackgroundColor))),
      child: ListTile(
        leading: Icon(icon, size: 22, color: Theme.of(context).primaryColor),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        onTap: tapHandler,
        trailing: Icon(Icons.arrow_right,
            size: 22, color: Theme.of(context).primaryColor),
      ),
    );
  }

  /// List Tile
  static Widget listX2Tile(BuildContext context,
      {String title, IconData icon, Function tapHandler}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
      child: Row(children: <Widget>[
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(width: 16.0),
        Text(
          title,
          strutStyle: StrutStyle(forceStrutHeight: true),
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(fontWeight: FontWeight.w600),
        )
      ]),
    );
  }

  static Widget listTileX2(BuildContext context,
      {String title, IconData icon, Function tapHandler}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
      child: Row(children: <Widget>[
        Icon(icon, color: Theme.of(context).primaryColor),
        SizedBox(width: 16.0),
        Text(
          title,
          strutStyle: StrutStyle(forceStrutHeight: true),
          style: Theme.of(context)
              .textTheme
              .subtitle2
              .copyWith(fontWeight: FontWeight.w600),
        )
      ]),
    );
  }

  static Widget horizontalListTile(BuildContext context,
      {String title, IconData icon, Function tapHandler}) {
    double width = MediaQuery.of(context).size.width * 0.28;
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: InkWell(
        onTap: tapHandler,
        child: Container(
          width: width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.black12)),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(icon, color: Theme.of(context).primaryColor, size: 32),
                SizedBox(height: 8),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  strutStyle: StrutStyle(forceStrutHeight: true),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.grey),
                ),
              ]),
        ),
      ),
    );
  }
}
