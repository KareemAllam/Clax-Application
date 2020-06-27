import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

class BottomSheetTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  BottomSheetTitle({this.title = 'عنوان البوتم شيت', this.icon = Icons.cake});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        color: Theme.of(context).primaryColor,
      ),
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.values[5],
                ),
          ),
        ],
      ),
    );
  }
}
