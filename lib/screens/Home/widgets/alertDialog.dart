import 'package:flutter/material.dart';

showAlertDialog({
  BuildContext context,
  String content = 'رسالة',
  String code = "العنوان",
}) {
  // set up the button
  String title;
  Icon icon;
  String description;
  if (code == 'success') {
    title = 'مبروك';
    description = 'تم تفعيل العرض بنجاح';
    icon = Icon(Icons.card_giftcard, color: Colors.white); //gift
  } else if (code == 'incorrect') {
    title = 'عذراً';
    description = 'هذا العرض غير صحيح';
    icon = Icon(Icons.do_not_disturb, color: Colors.white);
  } else {
    title = 'عذراً';
    description = 'هذا العرض غير موجود حالياً';
    icon = Icon(Icons.do_not_disturb, color: Colors.white);
  }
  Widget okButton = FlatButton(
    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
    child:
        Text("حسناَ", style: TextStyle(color: Theme.of(context).primaryColor)),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
    ),
    titlePadding: EdgeInsets.all(0),
    title: Container(
      child: Row(children: [
        icon,
        SizedBox(width: 10),
        Text(title, style: TextStyle(color: Colors.white))
      ]),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    content: Text(content == "ds" ? '$description \n$content' : '$description'),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
