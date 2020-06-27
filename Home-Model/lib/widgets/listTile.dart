import 'package:flutter/material.dart';

Widget buildListTile1(BuildContext context, String title, Function tapHandler) {
  return ListTile(
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),
    ),
    onTap: tapHandler,
    trailing: Icon(Icons.arrow_right, size: 22),
  );
}

@override
Widget buildListTile(
    BuildContext context, String title, IconData icon, Function tapHandler) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            top: BorderSide(color: Theme.of(context).scaffoldBackgroundColor))),
    child: ListTile(
      leading: Icon(icon, size: 22, color: Theme.of(context).primaryColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      onTap: tapHandler,
      trailing: Icon(Icons.arrow_right,
          size: 22, color: Theme.of(context).primaryColor),
    ),
  );
}
