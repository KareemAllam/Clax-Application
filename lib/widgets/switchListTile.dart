import 'package:flutter/material.dart';

Widget buildSwitchListTile(
  BuildContext context,
  String title,
  String description,
  bool currentValue,
  Function updatedValue,
) {
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
        style:
            Theme.of(context).textTheme.caption.copyWith(color: Colors.black38),
      ),
      value: currentValue,
      onChanged: updatedValue,
    ),
  );
}
