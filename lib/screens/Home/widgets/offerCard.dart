import 'package:clax/models/Offer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart' as intl;

class OfferCard extends StatelessWidget {
  final Offer offer;
  OfferCard(this.offer);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          // top: BorderSide(color: Colors.grey[350]),
          bottom: BorderSide(color: Colors.grey[350]),
        ),
      ),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.percent,
                    size: 14, color: Theme.of(context).primaryColor),
                SizedBox(width: 16),
                Text(offer.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontWeight: FontWeight.bold))
              ],
            ),
            Text(
              intl.DateFormat('MMMM d').format(offer.end).toString(),
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.grey),
            )
          ],
        ),
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            width: double.infinity,
            color: Theme.of(context).primaryColor,
            child: Text(offer.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
